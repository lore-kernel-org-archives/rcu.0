Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF34C433DF
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08F62074A
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cmK3KVNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYWvH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHYWvF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 18:51:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A27C061755
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:51:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i20so155150qkk.8
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lz7Ete1HXeK/9NWmX4iXi72UXTwnQy+boNBkraeiIfc=;
        b=cmK3KVNWwPBBD9n9vWY41oNG3RxLjaxZospd1pU/v7R/iAUTgif12lQMVixLmu6tQr
         Irff7h1Iydpwxjk3t9humO3YYGtxvDSIeO2GfofyEtqh2UZW6WB0aitNRMPtRhYbsmKX
         DtFzdi4NpFs1+rZYJ3ISGDFgYgT/KFg8wxuMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lz7Ete1HXeK/9NWmX4iXi72UXTwnQy+boNBkraeiIfc=;
        b=K73XEXi+7PJjLftzrhpeDyXIr0PcejvBd0w5bgHWUsTLVKlX5LkBb6NeuUn6zUFQpK
         co41mDeTwSEl2st+2ayqT715LlT6LVWTrVHsO/TBKhXa6jQdj6HVXXBqO6gVsFxDdCkN
         zmdOulIc3wuASeH6SO2ECOI4GTI47lETDu3kmesXdX7t4apzVK+sHkNcD2PluMKAP8DP
         kFRyMtKMiSuNUw/lRJ4KUjq/GWgzp73eV3CcQYJgBD9CUhnnsyJJzXsB4wf7xN/oa6kV
         wmH1Ee7Da9GNT6BDvosh9sBB2v/nZU3aQEmzK1qk0WaT8BYE/majDw7IBjqrJ84b7G0H
         f+tA==
X-Gm-Message-State: AOAM5320+7v7P7RmqPe9bbdJNgPBFLXV7Ph2oGRnV8IknN+BUlt7VNxi
        6jTId7G5Wd2byz2BRDjJPhX5dA==
X-Google-Smtp-Source: ABdhPJypySxBnDrgu9Hicp7OFuSSI3r1KMRBPIfCicxTuNz4D+e2vSDO294m6TNJyQ27V8a9L6DWaQ==
X-Received: by 2002:a37:ae03:: with SMTP id x3mr11322595qke.313.1598395864585;
        Tue, 25 Aug 2020 15:51:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k3sm233628qkb.95.2020.08.25.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:51:04 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:51:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 3/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200825225103.GC579506@google.com>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-4-joel@joelfernandes.org>
 <20200825215338.GA16846@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825215338.GA16846@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 25, 2020 at 02:53:38PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 24, 2020 at 10:48:41PM -0400, Joel Fernandes (Google) wrote:
> > Add counting of segment lengths of segmented callback list.
> > 
> > This will be useful for a number of things such as knowing how big the
> > ready-to-execute segment have gotten. The immediate benefit is ability
> > to trace how the callbacks in the segmented callback list change.
> > 
> > Tested by profusely reading traces when segcblist counts updated.
> 
> Might I recommend a more repeatable and sustainable test methodology?
> (Sorry, couldn't resist, given that you left yourself wide open for
> that one...)

Ah, this message was from an older series :-(. I did test it with rcutorture
for many hours. But I forgot to update this commit message. :-(

I will respond to other comments soon, I am still stuck on the comment about
rcl.len and rcu_barrier interaction that you brought up in 1/4 and 2/4.

Thanks!

 - Joel

