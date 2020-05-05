Return-Path: <SRS0=P2/q=6T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63295C47254
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 11:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352B2206D7
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 11:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwTwCOS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEELD0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 May 2020 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEELDZ (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 5 May 2020 07:03:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC70C061A0F;
        Tue,  5 May 2020 04:03:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a4so978476lfh.12;
        Tue, 05 May 2020 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3xkwFF5dOZ2RDq1UBB0lVLNrru5zFIMvLUOVpyqz6+A=;
        b=cwTwCOS54pbErQ0fdBL0vS5S3Xmjp0kGkcjQ9Mhy2iaiJyjwkzD+TqlF1jmFBbyeEP
         BUV9Zsfr25k9IaOv5MXTIpgfsy1u1mOp4YlVSgr/iY65CjlDB1BnwOuC7lKFtYmLYwT8
         PS9Cy4bjxxteruOhfDC79Zas3dmzaIV56RR3WqnSJRjDC41zQe3GlI4Q+D2foz78gRBa
         5a2qXJuyVz5jWF2OkbwNBGJyRvCF+2jJ+H4AavhCJVSiZOHfGuoMSu9dUIH6CYqyf87u
         LeCEc1K3XDMHzpYykjTYKoknLk9rT49Ia+kRFuA9GiVDtY4v7TX0NFpm1uf+Aw5r9UgG
         8V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xkwFF5dOZ2RDq1UBB0lVLNrru5zFIMvLUOVpyqz6+A=;
        b=P6UjHDF33I5XuTCfN3GaSCAzefVHcSPDZKgMd5Uw72yNergc1ncSq3pVUskYk/EQAi
         yu9WeYQFw8ldwwQq/lhXeB77LCidyy2NzZAhQIDZQ1v7c5848qW9gKU4kF5rXDkJrOa4
         lrhbiPEGv96F8JL1EVWXxFjuohmeJnpXoVsNYCBemISCSIsaH2brakG5CuLwL5tjCkjX
         lmq9sii/ZRKfu8kc+4LmJyAZADsQOYX9qQpyb8Vdk7g0QMwWhiIVG8Af/9zAhxI52u8L
         Pq/iUC7ZlmBd8NPJziiiedCPkt6EJrmgzURUh3BB6e2Jp+MyKbZPi/cA67h5CZqgc7kH
         13Xg==
X-Gm-Message-State: AGi0PuZbULVl+HMPvKJu06Q+pTKxh9nTA9/NShaEp0FqmXddW8r1uhea
        s6Cq6OvXH4Qirmd2soqyCJ2gdgzc+k3ulQ==
X-Google-Smtp-Source: APiQypLfCp0VzDXdDAXX3f8TJDDjAIHyi4mv0Mb8SM26DrkQwGwewhY9Wsmw9Yer7x+37mKK1DS36A==
X-Received: by 2002:a19:5206:: with SMTP id m6mr1320669lfb.33.1588676603679;
        Tue, 05 May 2020 04:03:23 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id k6sm1487807lfm.91.2020.05.05.04.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 04:03:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 May 2020 13:03:20 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200505110320.GA23774@pc636>
References: <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com>
 <20200504190138.GU2869@paulmck-ThinkPad-P72>
 <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
 <20200504195128.GA21830@pc636>
 <20200504201641.GV2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504201641.GV2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 01:16:41PM -0700, Paul E. McKenney wrote:
> On Mon, May 04, 2020 at 09:51:28PM +0200, Uladzislau Rezki wrote:
> > > > > Since we don't care about traversing backwards, isn't it better to use llist
> > > > > for this usecase?
> > > > >
> > > > > I think Vlad is using locking as we're also tracking the size of the llist to
> > > > > know when to free pages. This tracking could suffer from the lost-update
> > > > > problem without any locking, 2 lockless llist_add happened simulatenously.
> > > > >
> > > > > Also if list_head is used, it will take more space and still use locking.
> > > >
> > > > Indeed, it would be best to use a non-concurrent singly linked list.
> > > 
> > > Ok cool :-)
> > > 
> > > Is it safe to say something like the following is ruled out? ;-) :-D
> > > #define kfree_rcu_list_add llist_add
> > > 
> > In that case i think it is better just to add a comment about using
> > llist_head. To state that it used as a singular list to save space
> > and the access is synchronized by the lock :)
> > 
> > IMHO.
> 
> But adding such a comment would be fine as well.
> 
Thank you Paul and Joel!

--
Vlad Rezki
