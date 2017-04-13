def path_to(page_name)
    case page_name
    
    when /^the Home Page/
        '/home/index'
        
    when/^the Available view/
        '/home/availables'