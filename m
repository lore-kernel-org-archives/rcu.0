Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B2C1975A
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B88206EB
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 19:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+IgWix3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLTKU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:10:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46915 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTKU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 15:10:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id r9so306177lff.13
        for <rcu@vger.kernel.org>; Thu, 12 Mar 2020 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NZjOqvmaVXe1hUyZVDwwpquz85u2HiiolkLgj11/mwA=;
        b=p+IgWix3q0Tw6xh5gt3OCUtgudiLEtSphPWigK20Xv/RGU4x9QXMgzsmw1KNnKw7Nu
         mdQWnMp3pO+h16TBmkYBj9Ujnw7FJkV6lwPAZiDMfGrReAuwqm+bG+FY4rnxTDJl5V7q
         vAhQzUsiZFOGDw6dG68Ki7uFOm9DIcz5Ys/ab/I7LztUcytNAh3cteetnK5qKUgWnnL3
         kHHqma4H6DNKvl+PTga20L7ev4Asa+OnNTeHToug2G/xZq0I/d/xatN99QuUflBAIfeV
         H3nEMjD0t1km8F2AVvwBcz4oSpwgCmBkrD8ov9tmRnhNj6mzdBpBoapIox0R89eK9B+q
         Yg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NZjOqvmaVXe1hUyZVDwwpquz85u2HiiolkLgj11/mwA=;
        b=dGiw1TZJNUAMXuj1G9oA3eE1cltfvrXKtcYUNW/uyWaaApynXyrh3p3PsNSDg9BLIh
         NXcwEvQmhOI0QMl3WBrVJO1ZwTi9DoEYorQVbrySrnDVAGaqRvaHhiWnnZ581g3e3bkn
         bFNuJLSVzhcxrX8BB1z+VVP5EY+/w3n4ESpxEJYAvfiCbPdFau5+xxVMGHBsIOoWs3Fz
         T6YTAgWYa7hBMeTWDnFV/hk5xsjMLVNTLJmrjTXNQljBMfjPzqRBVMBHNhyv5HX9m9eZ
         +as70dPyXjrtTjn4Q8fpb4QEpSS5++4sG7ZQPPhQtjjUTIO9rpXlFfv4lCc6Hb6BGJ+V
         msvg==
X-Gm-Message-State: ANhLgQ0dv1uKXRqAIVEwRO92DnyEZYYliUMIK/mkUlATe8F4qnaY6nTr
        ydraQ3Crye6myzFajmMS/QI=
X-Google-Smtp-Source: ADFU+vtuw5o+/XieITpRtNwI9bHqjrW1CHZ8q3O1GG6iPv5z4cfWCo4vB9Z6/9safcP/3O8aLSC6BQ==
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr5844963lfn.148.1584040217464;
        Thu, 12 Mar 2020 12:10:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c20sm21214333lfb.60.2020.03.12.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:10:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 12 Mar 2020 20:10:09 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "joel@joelfernandes.org George Spelvin" <lkml@sdf.org>
Cc:     George Spelvin <lkml@SDF.ORG>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, urezki@gmail.com
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200312191009.GA27429@pc636>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312181138.GI3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 11:11:38AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 12, 2020 at 04:27:30PM +0000, George Spelvin wrote:
> > kvfree() is a superset of kfree(), so there's nothing obvious stopping 
> > kfree_rcu() from simply changing to kvfree() and everything will keep 
> > working.
> > 
> > I'd probably add a kvfree_rcu() alias, just for documentation's sake and
> > to make code that depends on the new feature explode at compile time, but
> > it could be identical behind the scenes.
> > 
> > There's an existing user in mm/list_lru.c already.
> > 
> > I was just thinking of using kvmalloc() in a module, and realized that the 
> > lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
> > module unload.
> 
> There was a recent proposal to do just that, but current patches in -rcu
> use kfree_bulk().  It doesn't look to me that this works for kfvree()
> under the covers in its current form.  Could it be upgraded to handle
> this case?
> 
> Adding Vlad on CC for his thoughts.
> 
Paul, see below my view:

Answering to topic's question it looks like we need kvfree_rcu() support :)

It is easy to add it actually. But if we are talking about the case when
an object has rcu_head inside. From the other hand recent discussion showed
that we would like to have head-less variant of the kvfree_rcu() functionality:

https://lkml.org/lkml/2020/2/18/566

for example, as Ted pointed, he would go with head-less case(for ext4) only.
The reason is nobody wants to modify internal structures injecting rcu_head
there. Also there are many other places in the kernel where it would be good
to have kfree_rcu() head-less variant as well.

I spent some time implementing it together with Joel. It is ready from my
side but only for RCU-tree case. Next step is RCU-tiny support, so i am
working on it.  

I can send out an RFC for RCU-tree only support, so we can discuss it
and agree on how to move forward. After that i or Joel or together can
update RCU-tine.

Joel: What do you think?

Another thought. We can add kvfree_rcu(ptr, rcu) first, because it is
easy and after that implement head-less case.

--
Vlad Rezki
