Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C0C433F5
	for <rcu@archiver.kernel.org>; Fri, 11 Feb 2022 15:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiBKPPe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:15:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346356AbiBKPPe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Feb 2022 10:15:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D4EB09;
        Fri, 11 Feb 2022 07:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E0561FE0;
        Fri, 11 Feb 2022 15:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0135C340E9;
        Fri, 11 Feb 2022 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644592532;
        bh=nFRgSKvwAAezcRTe3BlfBJ2UaYENDz2QwEV0upYpAVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpqJ/LqSqlmzt6LQ0U9iC9uh6Yp72ceXI7i+8xnNmohwxA5K2uQu7EbuI28n3IMX3
         MqacXNqXn//UiLk7bQUX+8ToY5hRRhTlwfH6IsSqyXZtytwdRXNX9ETMLObn1YvvlU
         76gGrx/Pz5E3LL/teMNud6vXYTz9BjK9cCdAd6q5ahfdI6Ji1T6sfNdQfXQhuMVExh
         lEfE9H0hlLKKOOKn75OxTXVU+9J7U9Ifj6BHkXuR/r5eUQIjnsf6b2fLE0kbHLWACo
         vI61Vu8OXlWufdwMTkocd28vawGCacsSyBYT3ydgJCZEd6VRjsFXkxDEegs9G67v8L
         KzuJppQLi1beg==
Date:   Fri, 11 Feb 2022 16:15:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH rcu 1/9] MAINTAINERS:  Add Frederic and Neeraj to their
 RCU files
Message-ID: <20220211151529.GB588079@lothringen>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204230805.4193767-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 04, 2022 at 03:07:57PM -0800, Paul E. McKenney wrote:
> Adding Frederic as an RCU maintainer for kernel/rcu/tree_nocb.h given his
> work with offloading and de-offloading callbacks from CPUs.  Also adding
> Neeraj for kernel/rcu/tasks.h given his focused work on RCU Tasks Trace.
> As in I am reasonably certain that each understands the full contents
> of the corresponding file.
> 
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks! :)
