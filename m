Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93DC2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070752074B
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t12SCC7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgKDOgx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKDOgx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 09:36:53 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F5C061A4A
        for <rcu@vger.kernel.org>; Wed,  4 Nov 2020 06:36:53 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id o205so12646840qke.10
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2020 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIr0lJXtiFGz2bnTfSBzXYbPqtfqn5n6TkaR8vQe3Qo=;
        b=t12SCC7mhFlP8NeVsHLtlKBUiRsgIGL2XL2ja+oo/2LA1K6U7mJ5j0NO0805MvnvIq
         nuxeTT0jvhf60k1aHJ+4GiFCyIJLqHmAIkwkw8Ww2F7L69i5ecuKeNiMRu26hp3Cvmwm
         ORkhgXyrs6zkv3bgIdmYwpvGZcBxs01fJyu5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIr0lJXtiFGz2bnTfSBzXYbPqtfqn5n6TkaR8vQe3Qo=;
        b=k2k2CbyRKONKpm93rlJFSgJtZCJFo8fdlRJ/3QHs9ORPlcqL34UDbTVzOTTFcgh6rN
         bb/xsLcXiHJZbq1qRUt+w4wkQQunBc/N1PNgbFccU7Xd2hleNCLB39SFCHaaSfYR3cda
         pTFcAzHHZ/qMEkE2uHLyBXBrjKmPMrvr98rUYoIwmfgKcwtunQIGZ0DMd+GJRFU/ezGf
         3ZZl6p4CZ9RBya9Xn5JPVVJXyCQmIMGAmRjncbMrBlYuXvxORDeBaoV5w/wqX4SD9XQX
         7lbmg+z38ptXVGzySXPCSPsHtubJ1UTKcLOFueUhHHBW621Znf7+Y5D/T8zQYIQnL258
         667A==
X-Gm-Message-State: AOAM532fQ2qBruswM13EZGLTa/qdxcpeDoM4GnnqqklgyLJsuBZ7KD21
        QpCdQnWkj9TBdrHOfRRZO41OZg==
X-Google-Smtp-Source: ABdhPJyPc9nBgsF2q2hGkbpCTcvazLIdnEmZ48OOg+nCLVJ2eAggO01IjIb678ztsccPASCM/JrUKg==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr1318432qkg.228.1604500612536;
        Wed, 04 Nov 2020 06:36:52 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x21sm2801960qkb.78.2020.11.04.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:36:51 -0800 (PST)
Date:   Wed, 4 Nov 2020 09:36:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 15/16] rcu/tree: Allocate a page when caller is
 preemptible
Message-ID: <20201104143651.GA2313912@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-15-urezki@gmail.com>
 <20201103180316.GC1310511@google.com>
 <20201104113931.GA17782@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104113931.GA17782@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 12:39:31PM +0100, Uladzislau Rezki wrote:
[..] 
> > > -	if (!krcp->bkvhead[idx] ||
> > > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > -		bnode = get_cached_bnode(krcp);
> > > -		/* Switch to emergency path. */
> > > +	if (!(*krcp)->bkvhead[idx] ||
> > > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > +		bnode = get_cached_bnode(*krcp);
> > > +		if (!bnode && can_alloc_page) {
> > 
> > I think you can directly put preemptible() here with a comment saying
> > allocate only if preemptible and get rid of can_alloc_page.
> > 
> Not really. We check preemtable() before acquiring the internal lock,
> otherwise it will always return "false". Thus, it is checked on the
> entry in the beginning.

You are right. Sorry. Sounds good to me.

 - Joel
