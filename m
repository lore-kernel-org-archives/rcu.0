Return-Path: <SRS0=rUw8=DU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B1C433DF
	for <rcu@archiver.kernel.org>; Tue, 13 Oct 2020 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090B4252A5
	for <rcu@archiver.kernel.org>; Tue, 13 Oct 2020 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602606846;
	bh=r+85fSMCDOxwAe4TvrYGl0G0qWopOPgFVSKadDsPvHo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QW5w/AgJPReHXXMGJlXc9spV7y9PYPq3jR5FYeJBAar9J7xe58ZR4HeGZalt7wz/k
	 gTNv4sIMwEdAzzIAjeYODLLamBeGs9zujw1e4fg0xgV+Q2WXDqGXJpLU9dcf7w7DSB
	 gIcMHTZj+bGqhSlEidtFClb/f1UkqmS6Bnq98dmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgJMQeF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Oct 2020 12:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJMQeF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Oct 2020 12:34:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F6225298;
        Tue, 13 Oct 2020 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606844;
        bh=r+85fSMCDOxwAe4TvrYGl0G0qWopOPgFVSKadDsPvHo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xU1F0SkQ6zvDSM4LoD/Oyots66oZze9PaUGMR2Q8tVHLVvOhZ2rHTul3JtRNuFXK+
         DRFXUk2SsZAFInDHe3FtHA1/lSnMif0N0PMedGwoFvTf+HDgtPYTt14JxEmjqsZKgJ
         JquLS1E2aTqBpKjaodoznmLxYOIR+908FL4aihA0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A9AFE3522A36; Tue, 13 Oct 2020 09:34:04 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:34:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 70/80] rcu/tree: docs: document bkvcache new members
 at struct kfree_rcu_cpu
Message-ID: <20201013163404.GP3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <6dd0804d6fd567f11e4c6efb767e91acca659d1f.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd0804d6fd567f11e4c6efb767e91acca659d1f.1602589096.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 13, 2020 at 01:54:25PM +0200, Mauro Carvalho Chehab wrote:
> Changeset 53c72b590b3a ("rcu/tree: cache specified number of objects")
> added new members for struct kfree_rcu_cpu, but didn't add the
> corresponding at the kernel-doc markup, as repoted when doing
> "make htmldocs":
> 	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'bkvcache' not described in 'kfree_rcu_cpu'
> 	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'nr_bkv_objs' not described in 'kfree_rcu_cpu'
> 
> So, move the description for bkvcache to kernel-doc, and add a
> description for nr_bkv_objs.
> 
> Fixes: 53c72b590b3a ("rcu/tree: cache specified number of objects")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Queued for review and testing, likely target v5.11.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f78ee759af9c..03c54c3478b7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3022,6 +3022,12 @@ struct kfree_rcu_cpu_work {
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @rcu_work fields have been initialized
>   * @count: Number of objects for which GP not started
> + * @bkvcache:
> + *	A simple cache list that contains objects for reuse purpose.
> + *	In order to save some per-cpu space the list is singular.
> + *	Even though it is lockless an access has to be protected by the
> + *	per-cpu lock.
> + * @nr_bkv_objs: number of allocated objects at @bkvcache.
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -3037,14 +3043,6 @@ struct kfree_rcu_cpu {
>  	bool monitor_todo;
>  	bool initialized;
>  	int count;
> -
> -	/*
> -	 * A simple cache list that contains objects for
> -	 * reuse purpose. In order to save some per-cpu
> -	 * space the list is singular. Even though it is
> -	 * lockless an access has to be protected by the
> -	 * per-cpu lock.
> -	 */
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
>  };
> -- 
> 2.26.2
> 
