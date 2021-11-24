Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C19C433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhKXLGf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbhKXLGd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FAC061574;
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t26so6110657lfk.9;
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAxdv16U546dm1WOaowxEF86oohs7WJfQnSsWYrFUVM=;
        b=RAZXpsiagAajkfQuPb/mp5mAwfjQXXpXbZeBMJ7HmZgIigzV4pKx8mmRp2u9BFpGiS
         5Cq0s5dQxVqWkasZEFePQuA9lSuT6ck6bvPb+Sw5sL4lgrZuRRMQ+JUKw3vHOGZIPN3J
         cZO4vtvWgP4Sv8cDyrZyMqdEMWHCu4uNidYWXamWPVAJWnDOYSIk47xcep7tah+hIQEs
         q596+jPmU7nqw8HjOD/yqJN7E1Lljh6as8RBJC11xnzIY9vF45tlmNArSv/TD/MxlAs+
         g+xUM5IyRaiRvuEd0H2ze3dLhnrKX65nMlt9KJbrRMEsc0bkY0/WBKYIMvwsZsYrhdv5
         f6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAxdv16U546dm1WOaowxEF86oohs7WJfQnSsWYrFUVM=;
        b=OiMCf5oFC4xtf/IhkZW1xVySYo4eN88R/CIQnmfpV01LSgRCAYAcLS7p9wgY8KkhdR
         H6gFcEXbkw/mjT174jcHVLoxhFRSrQ1S8CBQq+NRJDXMw0VoDt20virV2qDdO1mtjCeU
         tTGiKqxzPx2wrj96ABSbqMttbvy9+WDbAXOOXnNSyAGDxS2iRco5Bts99jtiqAhCOqWy
         MVxkvD0oMceuk7ZT19BeJN57kyotMTjybud64t+aZJna1NQX32pVUKkNlBOhxALPoICw
         SBjgHDsDQtEFZkRNovl1oZLNkV3+3dzicyYSYFU4nWYHjN8E7VGI99/A3wGFvwRP5AAL
         Yw8w==
X-Gm-Message-State: AOAM533YjsHvJLLJRORn9/JUH2QM5gXihNtzn7DYHuTNmzf3irhZk569
        WaCIx0BiqHzrCM9j3Cm/GpEz8ZOSWbogJ3Vi
X-Google-Smtp-Source: ABdhPJxUpKsz8nbuY0SpwsoQiUcJUdeGK7awA5gMk8PFlGONVgDQ/v2YjmF0KVMwE7h2nP1ExqIS6w==
X-Received: by 2002:a05:6512:4012:: with SMTP id br18mr13382792lfb.215.1637751800214;
        Wed, 24 Nov 2021 03:03:20 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:19 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/9] ext4: Replace ext4_kvfree_array_rcu() by kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:01 +0100
Message-Id: <20211124110308.2053-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The ext4_kvfree_array_rcu() function was introduced in order to
release some memory after a grace period during resizing of a
partition. An object that is freed does not contain any rcu_head
filed.

To do so, it requires to allocate some extra memory for a special
structure that has an rcu_head filed and pointer one where a freed
memory is attached. Finally call_rcu() API is invoked.

Since we have a single argument of kvfree_rcu() API, we can easily
replace all that tricky code by one single call that does the same
but in more efficient way.

CC: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 fs/ext4/ext4.h    |  1 -
 fs/ext4/mballoc.c |  2 +-
 fs/ext4/resize.c  | 31 ++-----------------------------
 fs/ext4/super.c   |  2 +-
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5..7e8ff3ac2beb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3089,7 +3089,6 @@ extern int ext4_generic_delete_entry(struct inode *dir,
 extern bool ext4_empty_dir(struct inode *inode);
 
 /* resize.c */
-extern void ext4_kvfree_array_rcu(void *to_free);
 extern int ext4_group_add(struct super_block *sb,
 				struct ext4_new_group_data *input);
 extern int ext4_group_extend(struct super_block *sb,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 215b7068f548..b0469f7a5c55 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3109,7 +3109,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
 	if (old_groupinfo)
-		ext4_kvfree_array_rcu(old_groupinfo);
+		kvfree_rcu(old_groupinfo);
 	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
 		   sbi->s_group_info_size);
 	return 0;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b63cb88ccdae..ac6aa037aaab 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -17,33 +17,6 @@
 
 #include "ext4_jbd2.h"
 
-struct ext4_rcu_ptr {
-	struct rcu_head rcu;
-	void *ptr;
-};
-
-static void ext4_rcu_ptr_callback(struct rcu_head *head)
-{
-	struct ext4_rcu_ptr *ptr;
-
-	ptr = container_of(head, struct ext4_rcu_ptr, rcu);
-	kvfree(ptr->ptr);
-	kfree(ptr);
-}
-
-void ext4_kvfree_array_rcu(void *to_free)
-{
-	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
-
-	if (ptr) {
-		ptr->ptr = to_free;
-		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
-		return;
-	}
-	synchronize_rcu();
-	kvfree(to_free);
-}
-
 int ext4_resize_begin(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -906,7 +879,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	n_group_desc[gdb_num] = gdb_bh;
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu(o_group_desc);
 
 	lock_buffer(EXT4_SB(sb)->s_sbh);
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
@@ -969,7 +942,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu(o_group_desc);
 	return err;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 111b0498a232..3942cd271a00 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2759,7 +2759,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
 	sbi->s_flex_groups_allocated = size;
 	if (old_groups)
-		ext4_kvfree_array_rcu(old_groups);
+		kvfree_rcu(old_groups);
 	return 0;
 }
 
-- 
2.30.2

