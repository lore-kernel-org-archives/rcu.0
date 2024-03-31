Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB72F2B
	for <rcu@vger.kernel.org>; Sun, 31 Mar 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711883411; cv=none; b=q7JbnULGFqupXpg4jZlmft1ew3bluySDPeGfISLWjNQwy59drJGvGZWmzbJyN3YUMg60ZBW6kczo8SCs/muMsg7/8Y1YCcnO8H/Fzldfoxqyud/NH1iObcIHGY9abHyYJhMWJvINLxc4qLqTMQuiPPq4Xt1HpnkG6zYNeqp2jMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711883411; c=relaxed/simple;
	bh=7zwW9KIreH0IZYqQc72+PuaK6wUeWYwPE3MwUrTfPBQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=E74b1PXF8LlFF2DX6sp3UTsmLQhBUk+o8bGYI8jMKHxFvIBa4tMEQtGCLfrvbwELjnvaK6gLwZ8Au1PiVkl50rg3AAnJNZi7H1eBwWlSXyQUW0lwgq/EYAYsPPXJF5gePFFKuXkZALNNqvAPl2O6Xsb6TZxK82tqj/XjBYkDQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=EWHkhytp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EWHkhytp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29df0ca87d1so2680406a91.2
        for <rcu@vger.kernel.org>; Sun, 31 Mar 2024 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711883409; x=1712488209; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCydWgolwrTtyJElMVv/4E817DBWypE+K8apOjVOCB8=;
        b=EWHkhytpOStWZTmuHHRX+d9jlvdxQCFVtEGzyJNjw5sZnzFoptagMd8Tw8laXxz2d4
         dxywwGYBpnqPalsTwhAUyo+OwXQAVcSNpGJTV1bosHC33X0xhjSnqtCX26z1/iACeopX
         bpomFer2FuCVMq9Lf5LGx04EWGs3NCgAbEebw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711883409; x=1712488209;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCydWgolwrTtyJElMVv/4E817DBWypE+K8apOjVOCB8=;
        b=jPLkEpeS7dlIrV4g71M8bAeVXpy/1gUMHDm1nifflJS1OmwmSIXzftsMkx7zSqg7cq
         AibfBfMCWz39g7pFeVf2pX8KR6JyWdP8alTMtyVRC55BlcZccI5/Voa6hBaamzFL5P6i
         GTfN4Z0ZPIhX+ItJLMlK05lZCl9Gs1Xff1V3bn7vSuEvzQ0F7tjfJJfWAulWv6CKC4lp
         IXdBN5fYkocD40yoTH2A8WQLVESkyKv1+VbwmKOuXRptzOwui06po+a2owC6H0rkHDJk
         sysd+JbXgsEMNJd1AYsxHT3zx0JOkctqnINl8y8gfS8pernffi1tEBrIJKEH/ca01EE5
         XO+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9GE6NCv75/GdDSalu3QTuNuMZBMmQUCuc+KjLkO7010XreUpn3pyNu9lK+ZTN2pG/jrk8hlByUBtx+pvVl/LkwBAD
X-Gm-Message-State: AOJu0YxiND04yWBeTAji57LZuFLMHb6LKPN2GuktVirVtqVTUWZVzfR2
	Gpso7r0HducnR6gYOeHW8ybIO139ik/2PbsVcSlOen89Pz2M6xirTuC2fTOVppg=
X-Google-Smtp-Source: AGHT+IG1sVtP+t66+BTUyvsM447XLas/FA1zNyHwyNsgSEc7sjBwEOGTHPm9yyCaNCRKw/yjIAbpbw==
X-Received: by 2002:a17:90a:3fcf:b0:2a0:390e:f032 with SMTP id u15-20020a17090a3fcf00b002a0390ef032mr5398788pjm.32.1711883409289;
        Sun, 31 Mar 2024 04:10:09 -0700 (PDT)
Received: from smtpclient.apple ([185.216.231.131])
        by smtp.gmail.com with ESMTPSA id cx14-20020a17090afd8e00b002a20b83bd46sm4998548pjb.41.2024.03.31.04.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 04:10:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
Date: Sun, 31 Mar 2024 16:39:54 +0530
Message-Id: <769AEAAB-7DEA-4D94-8979-F01EDFD6EE46@joelfernandes.org>
References: <20240328075318.83039-3-jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>
In-Reply-To: <20240328075318.83039-3-jiangshanlai@gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: iPhone Mail (21D61)



> On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.com=
> wrote:
>=20
> =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>=20
> Prepare for arch-specific-defined rcu_preempt_depth_set().
>=20
> No functionality change intended, but it has to be defined as a macro
> as rcupdate.h is a very low level header included from areas that don't
> even know about the task struct "current".

Sorry I did not follow changelog. If some rcupdate.h includers do not know
about task_struct, how does adding a macro that uses current help?

Thanks,

 - Joel

>=20
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
> include/linux/rcupdate.h | 1 +
> kernel/rcu/tree_plugin.h | 5 -----
> 2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 16f519914415..210f65baf47c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -78,6 +78,7 @@ void __rcu_read_unlock(void);
>  * types of kernel builds, the rcu_read_lock() nesting depth is unknowable=
.
>  */
> #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
> +#define rcu_preempt_depth_set(val) WRITE_ONCE(current->rcu_read_lock_nest=
ing, (val))
>=20
> #else /* #ifdef CONFIG_PREEMPT_RCU */
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 36a8b5dbf5b5..b1264096d03a 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -387,11 +387,6 @@ static int rcu_preempt_read_exit(void)
>    return ret;
> }
>=20
> -static void rcu_preempt_depth_set(int val)
> -{
> -    WRITE_ONCE(current->rcu_read_lock_nesting, val);
> -}
> -
> /*
>  * Preemptible RCU implementation for rcu_read_lock().
>  * Just increment ->rcu_read_lock_nesting, shared state will be updated
> --
> 2.19.1.6.gb485710b
>=20
