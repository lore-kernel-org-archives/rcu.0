Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE453546FF
	for <rcu@vger.kernel.org>; Thu,  1 Oct 2026 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814443; cv=none; b=ayoZCjnIce3JQaYc+kgucZVzpcVajBsasZ6sw7BzTuGOR6f9LsMqRSaKldPykIk3ybpwoPFIq1/ypNYnticKPM5YOBCPZxVpGIGBvoFbgNU1EoB/IovC2lmNhsUcIn4MlAJZ+kRRlmID7hpJ4t8Wpyl+H1s9uh9XghEpIOSweDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814443; c=relaxed/simple;
	bh=mkJEtMXVnewaQWaa7emYCn9l85AZ82Eeo+UPDVwb/Ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y7j0PiAaYqcbclg3eAZOlVvDH8WXkza/chEUOLgUjAsHaiAKHWNwvwwZDlzo3GsvuyMNNWTtfUK1d7pBWZgANW1NjV5vquixTjPQis+kiQ8LSkKFAWAh22K7o1HMx3ou7Ov4xenK3Jf/leFCbjnmusoocCJYq6kmCHORiDSkTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AsIUoGt3; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AsIUoGt3"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df8d1e91c9so87810375ad.0
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2026 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790814441; x=1791419241; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHjizEd9MIZQguiTJSV62chQrotI4W8c7atuMs3Hr2g=;
        b=AsIUoGt3zAaxjGJOnWmDuQzW0Xlc5j5PGNsiYGDouVpIIkZdXrnf8WijNOuV6eC4zE
         OfwSUk8QO6eBoyMKD+4XaU0TjIzwoeDvo1EJ9uqHXxXxa1JRj24D9CH1zx0Pk36uT1xG
         FrpXirsqCkvLvA0ZzUjokPFJZG2bPQn1J1SqSMQkAaIKt9tm3y8qtpvOIc/ALkc21c+W
         Oy6LJA4d6VdCr7uFPBnaDQmlU+1IDJTq5ch9NceWLS6Li/OtdvlApwiAiq74zHuzUupy
         jTk5879yWcQOpge+y/gQHHaevkoynU5rDkzKeAGmP4h46bYk/62fjwDW8htgV9e+OOoF
         m3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790814441; x=1791419241;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHjizEd9MIZQguiTJSV62chQrotI4W8c7atuMs3Hr2g=;
        b=PuFID+Ufse3Sh7dXjItcDDtk+OM4d8w0Ak2033GwCBRadbxIagSoeUhPigcn85ipxA
         ECgpZQgWZfi9OSBNzcDBAOWlwUoJ27vNjTGQHmgJTCSMJztUE94wywnegrHWly1AI+iC
         HlUKfpcnhiooc3BQlnK4VxYco519qkk2nxs9KKgiKTPwIsFD5TtU/KD0MeLtmXaRPRlU
         Bh8lWKZYkqKkXK7ljn5/MZB9deKKDFa1bjqiKETbvEN8sYnBs2idASg1jDumO2v18V31
         dar5Ww+QlZddKnFYxipxciQbl21nu9vXc887fG8o12CZCHyibIK643g3Rx5M1zd1mvF+
         RdnA==
X-Gm-Message-State: AFq9FYLa/vnXqXUMc1NiygI9NU49MDwDjMM7VYsGJdO4qLQETk+VrtiR
	I67xZa052jE81uymFbeGkQ2xwtqNX44YiDcsd1zu3wtaoa2NDuElOyePNC1lyDfjv3Xbpwowgtf
	5va4qeQ==
X-Received: from plyv15.prod.google.com ([2002:a17:902:d68f:b0:2e2:dba7:5b84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78e:b0:2dd:b795:9cb6
 with SMTP id d9443c01a7336-2e2e4a13c4dmr24426465ad.21.1790814440632; Wed, 30
 Sep 2026 17:27:20 -0700 (PDT)
Date: Wed, 30 Sep 2026 17:27:19 -0700
In-Reply-To: <20260919003521.3134552-9-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop> <20260919003521.3134552-9-paulmck@kernel.org>
Message-ID: <ar2o5yyB-o12pAos@google.com>
Subject: Re: [PATCH 09/19] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()
From: Sean Christopherson <seanjc@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Sunho Park <shpark061104@gmail.com>, 
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com, 
	Zqiang <qiang.zhang@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Paul E. McKenney wrote:
> From: Sunho Park <shpark061104@gmail.com>
> 
> The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
> when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
> to detect callbacks that srcu_barrier() failed to wait for. However, the
> ->len counter is decremented only at the end of srcu_invoke_callbacks(),
> after the invoking loop has finished. Since srcu_barrier() can return
> right after the barrier callback is invoked, cleanup_srcu_struct() can see
> a non-zero n_cbs even though the cblist is already physically empty,
> falsely triggering the WARN_ON() together with a still-pending delay_work
> timer.
> 
> This can be triggered as follows, as seen in the syzbot report against
> kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):
> 
> 1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
>    period GP1.
> 
> 2. GP1 ends: a delay timer is armed and sdp->work is queued, but
>    sdp->work has not run yet.
> 
> 3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
>    srcu_segcblist_advance(), which moves the GP1 callback to
>    RCU_DONE_TAIL, and starts SRCU grace period GP2.
> 
> 4. srcu_barrier() is called. It queues its barrier callback after the
>    GP2 callback and waits for srcu_invoke_callbacks() to invoke it.
> 
> 5. GP2 ends: another delay timer is armed, and the sdp->work queued in
>    step 2 begins to run. Its srcu_invoke_callbacks() call invokes
>    srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
>    to RCU_DONE_TAIL as well, and then invokes all of them. However,
>    rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
>    run yet at this point.
> 
> 6. srcu_barrier() returns once its callback has been invoked, and
>    cleanup_srcu_struct() starts running. It finds the delay timer
>    armed in step 5 still pending and srcu_cblist's ->len still
>    non-zero (because step 5 has not reached rcu_segcblist_add_len()
>    yet), and WARN_ON() fires even though every callback has actually
>    been invoked.
> 
> Use rcu_segcblist_empty(), which checks the actual head of the cblist,
> instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
> Callbacks that have genuinely not been invoked yet still leave the list
> non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
> or queue callbacks after it.
> 
> Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
> Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
> Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Sunho Park <shpark061104@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Is this going to be grabbed for 7.3?  It shows up relatively frequently in KVM.
Not so much that it's truly problematic/alarming, but enough that it definitely
stands out.

Tested-by: Sean Christopherson <seanjc@google.com>
