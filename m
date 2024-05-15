Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE2745E7
	for <rcu@vger.kernel.org>; Wed, 15 May 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794378; cv=none; b=ZxgmNrkGHgUNgY6uxBWAQbTlsXF9nWwyDe4f+7KqWtoB2hS96am7odzpJ8VdXxdxa6vvLlLM98wpCw+yl5ujn8eUgQqsJEDWUzAXBuaLH79sjgLxoI6HmDljk0PdzUl7XAdUdJD2vtvbKs1ME2N/BNMZzjyaZUaFk6dTY65UhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794378; c=relaxed/simple;
	bh=qEcSw3lILLGvhKIjJLG6VoBEYR2tfcg32/p64k58ON8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2SiOc8S8UPYbDdZe7+1QNdHJz4tMG/guYalLpSdYIfiiK7vmqYuMSJ5lZDGdgUMFljEbFxW2iMpTSK/DrhFiNmSFKwRtnTL+lGiAbjmGqkswgS1+wx4VGcsRsedeIXK/CP2bKY5R0eR/Ssb/xRHS/NgpDzkbL/qfC3YVkbOPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6xSB8BD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6xSB8BD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOwdeJhBjSGNCAussjsFY04Bth4aIM7eWnKu5IfNLOU=;
	b=a6xSB8BDZYSSIU8jXKrS5zDG5dSki4kDhyuaE9+Seg/9fysC6SK0eixbZdhTMwQ2D6UD/f
	Rc0a+ZorKQJ40X5FUhyG8MaHumWf6hhtcVJhyG3Y0FmGN5pYkqeMiim2LuNHUBH/0v7kkE
	D/kk2moYAFOWR1Si9lTVNZzugrccm6c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-rtQUv4d0Mh2Vt4BmzoHVww-1; Wed, 15 May 2024 13:32:54 -0400
X-MC-Unique: rtQUv4d0Mh2Vt4BmzoHVww-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43dd9951c89so135623951cf.0
        for <rcu@vger.kernel.org>; Wed, 15 May 2024 10:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794370; x=1716399170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOwdeJhBjSGNCAussjsFY04Bth4aIM7eWnKu5IfNLOU=;
        b=Ks7VDoKo/FaHXZikKU6lthQRdgjrThrh+TX9mWR35ubtBmd5rpokXnTNcidygwy/Zb
         lIvpVBx2aUlsKj2ZBFp5qaSP0IaY8dai3FSRVOQcHu0QGQ9ELpsYl6TcJK4nq++milPe
         7X9ZUmUTmQmNaWlfrPDyPB6e+zNAufZPcblvnZT+uOBwds1z3yY3w+sL5TnE8jBaQxOM
         Wp4U0hspukBj5em5o6Jn4Q8yVno5jc4V8RnzAGKMFhL6Ur7X/e5rO7H9iBF9lKPSbKWl
         hguWif/kEK0gM9Z7BA+YXEZIbobkUu5a5c2YP63evSg3TOBO23BMkTsvRH541u/tHtE3
         gDzg==
X-Forwarded-Encrypted: i=1; AJvYcCWa7Ux2J7XZyKB/e5siuZLK9vc4lRGJqJg3MdxDUqlzW1bZeWfP/kgRZq01lDL4cSeBPIey7diRk7S7Ne6/XSPJnD6Y
X-Gm-Message-State: AOJu0YxIqVacRUyetyJA3qCIc9VFKdicQCQho3pXVbcSsOZS9KKiHSZm
	gigE4Z1i78AH+mtYe1Y0CXdDyutwNUFPKGTbWiUI25LBeroJF3riGa3qmQ6d3p/n1JPiVAfGnd8
	52fMK5m3CSkcqITyTBtgif3dizwxeI6Zr6k3rKJOfJyTbHrlska7kxBxL6+wcsaSYZzlipcFSMb
	8DRRydVWSNjjCiEKctherdxwxd/TN4CPttyA==
X-Received: by 2002:a05:622a:109:b0:43a:3502:8446 with SMTP id d75a77b69052e-43dec39be29mr341473871cf.28.1715794370290;
        Wed, 15 May 2024 10:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3J4mJbmHn1T6bjHxpYTkK8dZATZQr5Sa13WzDnCmuqUStezho5/sEVpt2rJSDEKrAgOg5Bw==
X-Received: by 2002:a05:622a:109:b0:43a:3502:8446 with SMTP id d75a77b69052e-43dec39be29mr341473421cf.28.1715794369830;
        Wed, 15 May 2024 10:32:49 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0e421dccsm54794051cf.53.2024.05.15.10.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:32:49 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/6] rcu: Remove full ordering on second EQS snapshot
In-Reply-To: <20240515125332.9306-2-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-2-frederic@kernel.org>
Date: Wed, 15 May 2024 19:32:45 +0200
Message-ID: <xhsmhikzfgev6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:
>
> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state. Also the GP kthread must
>   observe all accesses performed by the target prior it entering in
>   EQS.
>
> or:
>
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state. Also the GP kthread later
>   observing that EQS must also observe all accesses performed by the
>   target prior it entering in EQS.
>
> This ordering is explicitly performed both on the first EQS snapshot
> and on the second one as well through the combination of a preceding
> full barrier followed by an acquire read. However the second snapshot's
> full memory barrier is redundant and not needed to enforce the above
> guarantees:
>
>     GP kthread                  Remote target
>     ----                        -----
>     // Access prior GP
>     WRITE_ONCE(A, 1)
>     // first snapshot
>     smp_mb()
>     x = smp_load_acquire(EQS)
>                                // Access prior GP
>                                WRITE_ONCE(B, 1)
>                                // EQS enter
>                                // implied full barrier by atomic_add_return()
>                                atomic_add_return(RCU_DYNTICKS_IDX, EQS)
>                                // implied full barrier by atomic_add_return()
>                                READ_ONCE(A)
>     // second snapshot
>     y = smp_load_acquire(EQS)
>     z = READ_ONCE(B)
>
> If the GP kthread above fails to observe the remote target in EQS
> (x not in EQS), the remote target will observe A == 1 after further
> entering in EQS. Then the second snapshot taken by the GP kthread only
> need to be an acquire read in order to observe z == 1.
>
> Therefore remove the needless full memory barrier on second snapshot.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Still looking at the rest, but at least so far I'm convinced this one makes
sense.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e6828132007..58415cdc54f8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -325,7 +325,7 @@ static bool rcu_dynticks_in_eqs(int snap)
>   */
>  static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
>  {
> -	return snap != rcu_dynticks_snap(rdp->cpu);
> +	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
>  }
>
>  /*
> --
> 2.44.0

