//
//  HomefeedViewController.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/28/22.
//

#import "HomefeedViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "HomefeedCell.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import "Infinite.h"

@interface HomefeedViewController () <ComposeViewControllerDelegate, DetailViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) Infinite *lodingMoreView;
@end

@implementation HomefeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];


}


-(void) getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    [self refreshControl];
    //fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *post, NSError *error){
        [self.refreshControl endRefreshing];
        if(post != nil){
            // do something with the array of object returned by call
            self.postsArray = post;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if(error) {
            // Failure
        } else {
            // Success
            SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = loginViewController;
        }
   }];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"composeSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        
    }else if ([[segue identifier] isEqualToString:@"detailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *poster = (Post *)self.postsArray[indexPath.section];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.post = poster;
                
        //UINavigationController *navigationController = [segue destinationViewController];
        //DetailViewController *detailController = (DetailViewController*)navigationController.topViewController;
        //detailController.delegate = self;
    }
}


-(nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomefeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomefeedCell" forIndexPath:indexPath];
    Post *post = self.postsArray[indexPath.row];
    [cell setPost:post];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (void) InfiniteScroll {
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height,self.tableView.bounds.size.width, Infinite.defaultHeight);
    self.lodingMoreView = [[Infinite alloc] initWithFrame:frame];
    self.lodingMoreView.hidden = true;
    [self.tableView addSubview:self.lodingMoreView];
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += Infinite.defaultHeight;
    self.tableView.contentInset = insets;
}
    @end
    
