Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7A3B95EB
	for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357362; cv=none; b=LwF4JEoGEupYbKN40j3Upjm7AamAmeaJykkDtdVipIiPZRIfMv66HFbj226dQc6fBg51fMupi3XNN7QeInpMtd+GcCNA+Z9dajKZxEvXtQ1qpKJ7SkrGoxM/E9ECTwArXnQy4A7N2El/CTaot7LTtS9a3SbZVa6VKD7jvhFFEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357362; c=relaxed/simple;
	bh=FJRzbufEtBJAhLCkPlm5BxuuEKScVokDrohw9V0wWgI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw1/0nFMZwjLuOcUcSePvq52vDusWfBGduNX/52cdJN9Dlm97LywccfbhNMA3hObMTkJi6ug6yrivH4CrTAKbuM85cVCWD+tS7Di/dzAlj7a3OGZNwu3IBVaBBEayOZHCdaXZidRCuSNfnWGEEjYeM/3G5q0cB1Sg6UIygENwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3cPWLjI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3cPWLjI"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c953950dfso11683261fa.1
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786357359; x=1786962159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pYeuabCvSp2X+27QeVgnHc3kyISwurDqCe0A6joolwY=;
        b=j3cPWLjIBF5EubjaIeE5g7F2urbcTjnikWqnZfDp5l/0T5eoG2tYNeRctXcFomsgZs
         MeUEDx8DWSodxR+t98XUwXYNTx7qjWb4MsWEmLpCLSOAuKmkgYmJz8JLto/2lb6n7amn
         nkDGG4hZlsmRfJ4mA7btaPjIkI5o2vIWJJo3w4wP8+Jh5k/xGpgLwU0F89wJu5Ahv5dB
         Hf35earGUIDbd45Ksg+XVp6/Tf+uSP3tu6RDuUYD4PTEKZd8Iu+BEOabHFsA/+dzF4sH
         UymgeWQxNklnYHEK+RopZm/1/6ojLHSOCYkBI5UO+Pvg4tqe7T0bt4+xDH8FAeU1LNvG
         E2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357359; x=1786962159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYeuabCvSp2X+27QeVgnHc3kyISwurDqCe0A6joolwY=;
        b=OTnX6mail7EAYyiAeEY33fqhSEIk8wfPcVPZFzXPMi7bjqnKl1mocEL0FxJxuDpXSp
         OrVEmyZXqRhb2vjW4BGhj0KZI8wcWkv9WoVHRdYGDIS0eHfIqYQBuk61n5aQek0t8+u5
         OLgz9cO180kJHc6GKT+BhEk8hjzvk1gvD3qESjePyEWLUCP3NL4Tiywd+O1MQ6z+xW10
         ShGhAVjBp6KSWDQtwixz+F8QUYzxoUyU2qz0cqGKcdR4r1KI820ampck2xI2QqCS1EIY
         padzwLtv4reijYMRBW5apZ8og+of5uOORpRdLCh19UeuHRzm43vv0tFbkTfTtmAwipki
         lJ7w==
X-Forwarded-Encrypted: i=1; AHgh+Ro64VFRJPM1ebWCXomd622FbXmV9J8Mn7h/e/51hHzkuHj/3NwV0WkkGjmSYuKHMtA9mmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jemU73bNb3HOCr0pl5lCpcM5dNAQoFGFvDXcizlsa+rbGRUG
	P7TRtl4lcL/PmrogmawytlUWiSepz7+R39JrWmKmpDynS3U1SJe6sNzo
X-Gm-Gg: AR+sD12y3BzlHlpqiyR6oUeiyxOD4p/o6Rgb5zeyh7UBhVFj8OzrluVDggLUWA/dwnU
	AUdU1hxXB41A1U0xw/SttB9HuBbZEfg9Lh2JlhOlkDBgCL9zBXw8Y98iLBW2VWKSwzwprE/WG5k
	CxILTCoIxY3A6ueEhwaFLSQYUpw2iBk+KVXefsATjfl9U2t8BJU3LiUMHuEo7lqs9ekLB8qlM5/
	HG7sFlAQQuSCFh7eubvbTmrrT0peNe5zl70uuJDKk1V0k4/6QsWE+5XVj1+nTJI47tVc05JBeMj
	M2pqTMBqEweJsTmU/0kR9BMOwZaQLHFO5r1N2Ugc/LunfDA+YWGWB7CiRMfKZz5+lPzGPzCy9ck
	FyBwnpoTCDLKh5mct8Zp2o98eolmYldG6MgIHsFUJ2M06++Qa9zfwkYGWsgm9nf9yVgLsAyyRh7
	YjJuHrQwmqghi6NBv8+o9EiOzttw==
X-Received: by 2002:a05:651c:1586:b0:39e:ea4f:4202 with SMTP id 38308e7fff4ca-39fbb262b33mr47691471fa.31.1786357358435;
        Mon, 10 Aug 2026 03:22:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fddd67ec0sm22873191fa.30.2026.08.10.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:22:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 10 Aug 2026 12:22:36 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Boqun Feng <boqun@kernel.org>, kvm@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <anmmbDqk5rfi_Gsx@milan>
References: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop>
 <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org>
 <anibnhTYdwdn51FF@milan>
 <54244653-0825-4F1C-8852-003762176FE3@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54244653-0825-4F1C-8852-003762176FE3@infradead.org>

On Sun, Aug 09, 2026 at 06:44:55PM +0100, David Woodhouse wrote:
> On 9 August 2026 16:24:14 BST, Uladzislau Rezki <urezki@gmail.com> wrote:
> >On Sun, Aug 09, 2026 at 10:59:59AM +0100, David Woodhouse wrote:
> >> +	/*
> >> +	 * Try a non-blocking allocation first, leaving the spare untouched
> >> +	 * in the common no-pressure case so that it is still there when
> >> +	 * there really is pressure.
> >> +	 */
> >> +	node = kzalloc_objs(*node, rcu_num_nodes, GFP_NOWAIT | __GFP_NOWARN);
> >>
> >GFP_NOWAIT already contains __GFP_NOWARN. It is odd.
> 
> Ack, thanks. Will fix in my tree.
> 
> >> +	if (node)
> >> +		return node;
> >> +
> >> +	node = xchg(&srcu_spare_nodes, NULL);
> >> +	if (node) {
> >> +		schedule_work(&srcu_spare_replenish_work);
> >>
> >I am not sure but if there is a need in doing progress forward, probably
> >separate wq with WQ_MEM_RECLAIM | WQ_UNBOUND flags is better. It has an
> >extra rescue kthread to do the progress if no memory or high mem-pressure.
> 
> I don't think there is a *need* per se,  as all that happens is a few more less efficient grace periods before the allocation finally succeeds. And frankly, if memory pressure is that bad the efficiency of the grace periods is probably the least of your worries.

Probably. I was thinking about something like(example taken from driver.c):

<snip>
synchronize_srcu(&encl->srcu);
mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
kfree(encl_mm);
<snip>

i.e. when we need to free memory. We want a faster reclaim especially
when low memory conditions. From the other hand it looks like we do not
call quite often init_srcu_struct_nodes() from srcu_gp_end(), so no
strong opinion here.

--
Uladzislau Rezki
