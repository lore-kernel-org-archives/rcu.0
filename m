Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1229C7618D
	for <rcu@archiver.kernel.org>; Thu,  6 Apr 2023 18:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbjDFSOf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbjDFSOe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Apr 2023 14:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4120DA24B
        for <rcu@vger.kernel.org>; Thu,  6 Apr 2023 11:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3349617E2
        for <rcu@vger.kernel.org>; Thu,  6 Apr 2023 18:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46501C433D2;
        Thu,  6 Apr 2023 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680804871;
        bh=r3AV+ts3nvtZUQ6hazbhn5oSaDxT2hS1je6YZxXnF8k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=pvqBHkQjuIY+wxeuZU1y4EgH1pNgQNReTY3zTpzvvyUQam+yvGLM/7KMkyX/MOgNx
         62kfxMP9R3j2wVoNqFByzN16yCehMu7kym5bKeapljcwhJKPqzL1Cd2sj6FQaYAUSF
         KDv0lO1+/LrZGqZFXtYXMKbY0V9IVQlNJVEXYjnEuYsOIB3mXEDpAIt0ho1Ny8OB9k
         wIIOZpOcZ3Qak2Jm9VLVkIis5oH1EvtT1yXXFvAbsLToZDYmBEZW8vrPVU/YgRGngt
         Cq8nplVb2cRRN91s78UD/F/RqzMBAIOem7iBj4bnZXd0ABKcDOwvoCFFOAffgeiaYW
         lovPuzCcYapFw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C9AB215404B4; Thu,  6 Apr 2023 11:14:30 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:14:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     urezki@gmail.com
Cc:     rcu@vger.kernel.org
Subject: Kerneldoc fix to fold in
Message-ID: <906701b3-cedb-4e26-944e-f91ebf06a334@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Uladzislau,

Would the patch below (to be folded into your original) be a good fix
for the kerneldoc issue Stephen Rothwell pointed out?

							Thanx, Paul

------------------------------------------------------------------------

commit 7873a901c00f5c6d0f5b5b979584b4c7f1294563
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Apr 6 11:06:26 2023 -0700

    squash! rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
    
    [ paulmck: Fix kerneldoc issue raised by Stephen Rothwell. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9cc0a7766fd2..1be23a64f027 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2795,6 +2795,7 @@ struct kvfree_rcu_bulk_data {
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
  * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
