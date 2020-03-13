Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7ABC2BB1D
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078EB2074A
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JrjNekF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCMNkh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:40:37 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37515 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgCMNkg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 09:40:36 -0400
Received: by mail-qv1-f66.google.com with SMTP id n1so770096qvz.4
        for <rcu@vger.kernel.org>; Fri, 13 Mar 2020 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80eAfM6YSJoVYVME2XNAV9bJaw7GIE5f+Jv8ic4bamo=;
        b=JrjNekF2FDZrMljIESm8A3FwOmCLkIWgfehn+cRkykLvfaakMZJbyDDvC5XwgWvf0Y
         LqBm6EDom2DePH0K36w/qbznnpuCaNrUB0dHr+cKDQmYRINTcE2SWG7HdxhLWueJFGeo
         BySDZYF+MCwXRLe4n3opi9FL5o7g2tcM8fZrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=80eAfM6YSJoVYVME2XNAV9bJaw7GIE5f+Jv8ic4bamo=;
        b=BaGZGL0xmzFGv25VQ+xCICaqYy3vAv543b1Vc4J/JU55it4d+0d8IqrQNsn4Dy8c20
         zUQAAPIikPVsgJiu5ohumRJtlbFOGKgJvGb9Pv2dxumEUi1Kd7Zsn+Nx7Hs1YafLODRL
         RpT7eYVbyry5PlydbqL0wr/zRrtF8u+HIj99tcKv5suxCOgyCCRw2RRv2xX3m78YQt1E
         MwYozq6SlWm+dGEt5U7GXiBp/ZcxgFz8NmMgvKDLKHh2PBDrMGZk1EixpeSco4pxzDYn
         Ng44FlouKC/jCF6dk6RDwBPsgWJ2WWQBcosyKwuRqiTqguBRkQnSziWIazEhFOtlbCYd
         /B0Q==
X-Gm-Message-State: ANhLgQ1O0Kc94PoYVBaMKwZhxuPSd4mVGMz3w56tdGptfv3uV4PU1e+j
        uQZUACwus74lnm9JdMg895bJXQ==
X-Google-Smtp-Source: ADFU+vu36RiLm1D+88l7APDBceX139PNH1PhZYy62yVJVG1fscoIIWndE2UFExHnFpeP/vLvyLXNuA==
X-Received: by 2002:a05:6214:1449:: with SMTP id b9mr12563611qvy.217.1584106834731;
        Fri, 13 Mar 2020 06:40:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d22sm10190601qte.93.2020.03.13.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:40:34 -0700 (PDT)
Date:   Fri, 13 Mar 2020 09:40:33 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "joel@joelfernandes.org George Spelvin" <lkml@sdf.org>,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313134033.GA60920@google.com>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313035809.GC190951@google.com>
 <20200313132124.GA28457@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313132124.GA28457@pc636>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 02:21:24PM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 12, 2020 at 11:58:09PM -0400, Joel Fernandes wrote:
> > On Thu, Mar 12, 2020 at 08:10:09PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Mar 12, 2020 at 11:11:38AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Mar 12, 2020 at 04:27:30PM +0000, George Spelvin wrote:
> > > > > kvfree() is a superset of kfree(), so there's nothing obvious stopping 
> > > > > kfree_rcu() from simply changing to kvfree() and everything will keep 
> > > > > working.
> > > > > 
> > > > > I'd probably add a kvfree_rcu() alias, just for documentation's sake and
> > > > > to make code that depends on the new feature explode at compile time, but
> > > > > it could be identical behind the scenes.
> > > > > 
> > > > > There's an existing user in mm/list_lru.c already.
> > > > > 
> > > > > I was just thinking of using kvmalloc() in a module, and realized that the 
> > > > > lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
> > > > > module unload.
> > > > 
> > > > There was a recent proposal to do just that, but current patches in -rcu
> > > > use kfree_bulk().  It doesn't look to me that this works for kfvree()
> > > > under the covers in its current form.  Could it be upgraded to handle
> > > > this case?
> > > > 
> > > > Adding Vlad on CC for his thoughts.
> > > > 
> > > Paul, see below my view:
> > > 
> > > Answering to topic's question it looks like we need kvfree_rcu() support :)
> > > 
> > > It is easy to add it actually. But if we are talking about the case when
> > > an object has rcu_head inside. From the other hand recent discussion showed
> > > that we would like to have head-less variant of the kvfree_rcu() functionality:
> > > 
> > > https://lkml.org/lkml/2020/2/18/566
> > > 
> > > for example, as Ted pointed, he would go with head-less case(for ext4) only.
> > > The reason is nobody wants to modify internal structures injecting rcu_head
> > > there. Also there are many other places in the kernel where it would be good
> > > to have kfree_rcu() head-less variant as well.
> > > 
> > > I spent some time implementing it together with Joel. It is ready from my
> > > side but only for RCU-tree case. Next step is RCU-tiny support, so i am
> > > working on it.  
> > > 
> > > I can send out an RFC for RCU-tree only support, so we can discuss it
> > > and agree on how to move forward. After that i or Joel or together can
> > > update RCU-tine.
> > > 
> > > Joel: What do you think?
> > 
> > Yes, your sending an RFC with what you have sounds good. I can prepare a tree
> > for both of us then and we can develop on that. I was actually waiting on
> > your patches so I can add more on top.
> > 
> OK. Let's setup something. Currently i am working based on dev.2020.02.16a
> branch. If you can, please do it and let me know so we can avoid of conflicts.

Ok, I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree

I will apply your patches to this branch once I have them.

> > One more thing I want to add is the shrinker interface to prevent OOM during
> > kfree_rcu() flood. I sent patches to fix that. It works well. We can prepare
> > a tree with all these features and develop on that so there's no conflict.
> > 
> > For -tiny and lack of rcu_head, I think we discussed that we would
> > always dynamically allocate rcu_head for that case.
> > 
> We can do dynamic attaching. Later on, i think we can implement "arrays" logic
> like we do for RCU-tree but without any batching. Simple array pointer store  
> mechanism for head-less case.

Yep, sounds good.

> > > Another thought. We can add kvfree_rcu(ptr, rcu) first, because it is
> > > easy and after that implement head-less case.
> > 
> > Yes, that is also fine. We can start simple and then keep improving it. I
> > think we have now 3 users who want head-less interface so ultimately we can
> > shoot for that goal (at later stage).
> > 
> OK. Then, i think i will make kvfree_rcu(ptr, rcu) interface and all the
> rest on top.

Ok, sounds good.

thanks,

 - Joel

> 
> --
> Vlad Rezki
> 
