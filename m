Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A0FC10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6FC206BE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVHZ8b2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCMNVl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:21:41 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33554 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCMNVl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 09:21:41 -0400
Received: by mail-lj1-f170.google.com with SMTP id f13so10507718ljp.0
        for <rcu@vger.kernel.org>; Fri, 13 Mar 2020 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrL7Wp9sw7b39Ni79r7pQA3So53CVf6g/dnqjQzpaxs=;
        b=CVHZ8b2AvAigIgE7nsCXD8x07EZhxtrbWA9+8IISqR6zab8xsmFEeIZgLIO79t/YGr
         vJqxxIRl6kmR24CApDJdPmLG3K3aZILhNrzbiWRdS1gxmyu5fyGtaM6fHRlsj3UzAcij
         fKcYtnsq2pXiKXBT6gYdIq0PsxoLbHW5JevIEUDMCegYeseCLeYaUA7sSft26RolgZ2n
         4i8AnDCRnLGFcLlsvHEi7cREqNECTEF32etcfbEwmx7B69PGmZhbiyjTMWqv2qw2++Cr
         JV5C2Wxc+haQuy2lfUORtbs24g6+4Co8qrD3+SaoPOQiL4W2b15ZfwBaGH2TchO3yGwg
         HRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrL7Wp9sw7b39Ni79r7pQA3So53CVf6g/dnqjQzpaxs=;
        b=YkcQPjWmyeV9pp78WlXNm3J2pOOty95SgGF9XQ2NuYmT6rmkVXF8ldBqXiuuzKu44R
         WPM1JE/tCdkZ3WZGGLVCOVTdNDCAdQ114ts9mKrLX+6ozW4kvC5vpG9+pLh/VlcR3jFx
         GC3/TewMUhONEf4uNqN1O5lbQHPUu81aXZb0OtewCY0mr1vj/KAPNPDfC0FTJ6dbkdIS
         c5S4P3mwJqFr12b5FpCsX1KRn0Bd+KSzCCrggImE+7UF4R0i+zeR7K9FbdJw0xcDOaoI
         RIV2fUnheHM1amVlIsEZOVxsOPxj0som+rgbNJiAxWg8+2pvJba6aOImUECTz61ppdI7
         T2PQ==
X-Gm-Message-State: ANhLgQ1VhXLFPCTAKWV2Nf6CzdqvjgTrtVccPDNXTwVY5Ivqozd9y/6b
        eIk2+5BtuLsRBg2E1A6wbIM=
X-Google-Smtp-Source: ADFU+vsynE0V2tMWR2T+fc0dVdkAn8c6XGGEqHVWmL2zFTL+gbHM7WKjuc/oIztAIau1kL7h2QCrJw==
X-Received: by 2002:a05:651c:50a:: with SMTP id o10mr1052834ljp.163.1584105698854;
        Fri, 13 Mar 2020 06:21:38 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z18sm24767064ljm.15.2020.03.13.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:21:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 13 Mar 2020 14:21:24 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "joel@joelfernandes.org George Spelvin" <lkml@sdf.org>,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313132124.GA28457@pc636>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313035809.GC190951@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313035809.GC190951@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 11:58:09PM -0400, Joel Fernandes wrote:
> On Thu, Mar 12, 2020 at 08:10:09PM +0100, Uladzislau Rezki wrote:
> > On Thu, Mar 12, 2020 at 11:11:38AM -0700, Paul E. McKenney wrote:
> > > On Thu, Mar 12, 2020 at 04:27:30PM +0000, George Spelvin wrote:
> > > > kvfree() is a superset of kfree(), so there's nothing obvious stopping 
> > > > kfree_rcu() from simply changing to kvfree() and everything will keep 
> > > > working.
> > > > 
> > > > I'd probably add a kvfree_rcu() alias, just for documentation's sake and
> > > > to make code that depends on the new feature explode at compile time, but
> > > > it could be identical behind the scenes.
> > > > 
> > > > There's an existing user in mm/list_lru.c already.
> > > > 
> > > > I was just thinking of using kvmalloc() in a module, and realized that the 
> > > > lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
> > > > module unload.
> > > 
> > > There was a recent proposal to do just that, but current patches in -rcu
> > > use kfree_bulk().  It doesn't look to me that this works for kfvree()
> > > under the covers in its current form.  Could it be upgraded to handle
> > > this case?
> > > 
> > > Adding Vlad on CC for his thoughts.
> > > 
> > Paul, see below my view:
> > 
> > Answering to topic's question it looks like we need kvfree_rcu() support :)
> > 
> > It is easy to add it actually. But if we are talking about the case when
> > an object has rcu_head inside. From the other hand recent discussion showed
> > that we would like to have head-less variant of the kvfree_rcu() functionality:
> > 
> > https://lkml.org/lkml/2020/2/18/566
> > 
> > for example, as Ted pointed, he would go with head-less case(for ext4) only.
> > The reason is nobody wants to modify internal structures injecting rcu_head
> > there. Also there are many other places in the kernel where it would be good
> > to have kfree_rcu() head-less variant as well.
> > 
> > I spent some time implementing it together with Joel. It is ready from my
> > side but only for RCU-tree case. Next step is RCU-tiny support, so i am
> > working on it.  
> > 
> > I can send out an RFC for RCU-tree only support, so we can discuss it
> > and agree on how to move forward. After that i or Joel or together can
> > update RCU-tine.
> > 
> > Joel: What do you think?
> 
> Yes, your sending an RFC with what you have sounds good. I can prepare a tree
> for both of us then and we can develop on that. I was actually waiting on
> your patches so I can add more on top.
> 
OK. Let's setup something. Currently i am working based on dev.2020.02.16a
branch. If you can, please do it and let me know so we can avoid of conflicts.

> One more thing I want to add is the shrinker interface to prevent OOM during
> kfree_rcu() flood. I sent patches to fix that. It works well. We can prepare
> a tree with all these features and develop on that so there's no conflict.
> 
> For -tiny and lack of rcu_head, I think we discussed that we would
> always dynamically allocate rcu_head for that case.
> 
We can do dynamic attaching. Later on, i think we can implement "arrays" logic
like we do for RCU-tree but without any batching. Simple array pointer store  
mechanism for head-less case.

> > Another thought. We can add kvfree_rcu(ptr, rcu) first, because it is
> > easy and after that implement head-less case.
> 
> Yes, that is also fine. We can start simple and then keep improving it. I
> think we have now 3 users who want head-less interface so ultimately we can
> shoot for that goal (at later stage).
> 
OK. Then, i think i will make kvfree_rcu(ptr, rcu) interface and all the
rest on top.

--
Vlad Rezki

