Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E54C77B61
	for <rcu@archiver.kernel.org>; Fri,  7 Apr 2023 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbjDGNms (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjDGNmV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Apr 2023 09:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58760BBA4
        for <rcu@vger.kernel.org>; Fri,  7 Apr 2023 06:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3BCF6512D
        for <rcu@vger.kernel.org>; Fri,  7 Apr 2023 13:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32523C433EF;
        Fri,  7 Apr 2023 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680874846;
        bh=JYb47zeKAiUP/30JHJoy+7+6tZtPUgjwMPsbmEUMC7U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BsQH6Df7zLIQgg6d3YzIOHxMnOw5qbd7T0sTLEnF0R0LomLgjXn5yAXK5CDWEdLcj
         EWBjMU5xULXiYCtn+RTaluV0KEyiqvTBA3oAgBB0pUADFOQcrOgJI/GO/cguzwphfz
         GpP53sJP/+ft7kDU8w1wnGNQDkVk1vB/r9osZ4Qtpw6U79br5G041FQImuz92RKovq
         9nPERawaEyMdb1dnDm1kICIsXXV5Y1A8pP43y0mQD6mggTB25ig7mT/vUd37KPIVx5
         B2rNdPq3vFU9VpyD7umJC9BOUcD587dwmbTo3xUPB94j2jkh8XhGVQqnS0hx4moODi
         CmgW264p7cjmg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DB22E154047D; Fri,  7 Apr 2023 06:40:45 -0700 (PDT)
Date:   Fri, 7 Apr 2023 06:40:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Kerneldoc fix to fold in
Message-ID: <6d4ed316-01ce-4102-86b2-6fbebc3b2769@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <906701b3-cedb-4e26-944e-f91ebf06a334@paulmck-laptop>
 <ZC/9HWX5LzSAiW3H@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC/9HWX5LzSAiW3H@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 07, 2023 at 01:23:09PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 06, 2023 at 11:14:30AM -0700, Paul E. McKenney wrote:
> > Hello, Uladzislau,
> > 
> > Would the patch below (to be folded into your original) be a good fix
> > for the kerneldoc issue Stephen Rothwell pointed out?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 7873a901c00f5c6d0f5b5b979584b4c7f1294563
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Apr 6 11:06:26 2023 -0700
> > 
> >     squash! rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
> >     
> >     [ paulmck: Fix kerneldoc issue raised by Stephen Rothwell. ]
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..1be23a64f027 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2795,6 +2795,7 @@ struct kvfree_rcu_bulk_data {
> >   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> >   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> >   * @head_free: List of kfree_rcu() objects waiting for a grace period
> > + * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
> >   * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> >   * @krcp: Pointer to @kfree_rcu_cpu structure
> >   */
> >
> Absolutely.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you for looking it over!

							Thanx, Paul
