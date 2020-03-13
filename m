Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA26C2BAEE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 03:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7722072F
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 03:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UssdtFo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMD6M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:58:12 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:42965 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCMD6M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 23:58:12 -0400
Received: by mail-qk1-f175.google.com with SMTP id e11so10329933qkg.9
        for <rcu@vger.kernel.org>; Thu, 12 Mar 2020 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bh1KG3uVyP7g3HRYxfdszobkMhYkJItQM5mNCYJX6v4=;
        b=UssdtFo2SLmp4NdTrz4n2ouRMwvj65jU1pbDXpLldKhWNZ0eKYT1tlICIYyK5WxtS6
         4zjJsMBsr2Ece0Ip/hAwg0o4Pskd8ERH05D9GsRUo8hhvqbGdjj1NYAQ6K+w7+Bideov
         zgst17Jqbq9FXpseFD1QF3lKmRjf8RQBzFVII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bh1KG3uVyP7g3HRYxfdszobkMhYkJItQM5mNCYJX6v4=;
        b=p/JfAwxhVA62sXFzoLHJ3+7owvgeVjZhQMHHERlsAk5eUNVfiFEYRUBOnmF8ITRwE4
         IIlbteTnD6vNNICvypXbN1R2kAgbykUsIO+pGG5ZEugivLi5WWKxzZUlzZqF0XbGjc96
         /P/eAYNp4YxHKuOU46O67iMUJnc0Op8I9QEAdp9NLzpjG34Kwuo4GX9HLZkkwDlQsR9Z
         DpFyjofID1OYkFSvEAkOs4U5PpFm5rhzb+0kIyAObXo+1V88YqJBBEEVzPEzIZgNyb8Y
         wpMd28aQ+URkr8BrAIbWmdHggiJK/ni043O6Mk74H8XvN/UADDPJeEjc6rkbV4QCV6LN
         529g==
X-Gm-Message-State: ANhLgQ11KulH2PEUTcj52s5GWWMVloBxGaLaMhVvxwOcbizMp1+Pt3na
        yFaZDsiNYctZhbkBFS8wHztqaw==
X-Google-Smtp-Source: ADFU+vvZpE8trH9aM7UQ1r3PYLFsrlgY5MDyR8aqrnLVhlOThB6v0877UwJTHBx8jkRT87Tl4oPImA==
X-Received: by 2002:a37:62d1:: with SMTP id w200mr10895403qkb.399.1584071890645;
        Thu, 12 Mar 2020 20:58:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k66sm16247568qke.10.2020.03.12.20.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 20:58:10 -0700 (PDT)
Date:   Thu, 12 Mar 2020 23:58:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "joel@joelfernandes.org George Spelvin" <lkml@sdf.org>,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313035809.GC190951@google.com>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312191009.GA27429@pc636>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 08:10:09PM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 12, 2020 at 11:11:38AM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 12, 2020 at 04:27:30PM +0000, George Spelvin wrote:
> > > kvfree() is a superset of kfree(), so there's nothing obvious stopping 
> > > kfree_rcu() from simply changing to kvfree() and everything will keep 
> > > working.
> > > 
> > > I'd probably add a kvfree_rcu() alias, just for documentation's sake and
> > > to make code that depends on the new feature explode at compile time, but
> > > it could be identical behind the scenes.
> > > 
> > > There's an existing user in mm/list_lru.c already.
> > > 
> > > I was just thinking of using kvmalloc() in a module, and realized that the 
> > > lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
> > > module unload.
> > 
> > There was a recent proposal to do just that, but current patches in -rcu
> > use kfree_bulk().  It doesn't look to me that this works for kfvree()
> > under the covers in its current form.  Could it be upgraded to handle
> > this case?
> > 
> > Adding Vlad on CC for his thoughts.
> > 
> Paul, see below my view:
> 
> Answering to topic's question it looks like we need kvfree_rcu() support :)
> 
> It is easy to add it actually. But if we are talking about the case when
> an object has rcu_head inside. From the other hand recent discussion showed
> that we would like to have head-less variant of the kvfree_rcu() functionality:
> 
> https://lkml.org/lkml/2020/2/18/566
> 
> for example, as Ted pointed, he would go with head-less case(for ext4) only.
> The reason is nobody wants to modify internal structures injecting rcu_head
> there. Also there are many other places in the kernel where it would be good
> to have kfree_rcu() head-less variant as well.
> 
> I spent some time implementing it together with Joel. It is ready from my
> side but only for RCU-tree case. Next step is RCU-tiny support, so i am
> working on it.  
> 
> I can send out an RFC for RCU-tree only support, so we can discuss it
> and agree on how to move forward. After that i or Joel or together can
> update RCU-tine.
> 
> Joel: What do you think?

Yes, your sending an RFC with what you have sounds good. I can prepare a tree
for both of us then and we can develop on that. I was actually waiting on
your patches so I can add more on top.

One more thing I want to add is the shrinker interface to prevent OOM during
kfree_rcu() flood. I sent patches to fix that. It works well. We can prepare
a tree with all these features and develop on that so there's no conflict.

For -tiny and lack of rcu_head, I think we discussed that we would
always dynamically allocate rcu_head for that case.

> Another thought. We can add kvfree_rcu(ptr, rcu) first, because it is
> easy and after that implement head-less case.

Yes, that is also fine. We can start simple and then keep improving it. I
think we have now 3 users who want head-less interface so ultimately we can
shoot for that goal (at later stage).

thanks,

 - Joel

