Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793847330;
	b=CDDhsICz6+zQjQbgIqNuMj3MqhwPcuGgA5507LXgnqWj8NMTVQjwertyy+nlckkNW4xX
	 QH0BoEaTYSV7SSscPk5b7AjT03HU6fpy043mR96Znwc91sAzmW1ztgVjKVc3jR/ltvEgR
	 88HqNExs8nqVCS9V+fujixzgpu8lRAo0siJNfyeXjxKXnLhz6xtfGIS8kSF0cCyMcF0ig
	 X/ABAtGEXkzbyORCj1KoiIgFL6WuPcwDgJVr6P9ab89stG8Hrft3JgwcZpZP8XRGTFDjX
	 1he/jGkmcDLPGK1XNXiEVM/2aBU5g7CkoFocTvPS0CuZCDSu7azMzgTBDzHsbN18y3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jR7loNAHPL1UfcJr49MgWtfYGIhpgreosCIZ48GmVGQ=;
	b=B6XCE8cc0BTg3Q3MBHA4yg7UnuCGUUrrWxZm93zSV5d7qqFM5oZ/xTA/l5tmHXaURFg8
	 JTv/Sa6DPtOZ/37YkrpLm3d9hJTxNYIx5jyXj6FH0c1jr6yfjFzpEphikBoreSySVgcFb
	 UFMuFkM+RzKXATrkpxXSxp1KdQShYRbAc6bjBaGI0qZJf3QzshSfGxpF5HPi3gMoAyOfT
	 ow+/xyOlx05p3+g1ZBY+mv/RCnA7PidEVlU8rCoUvLJjCfBpfoe6VacM4aZ+2C+Cs+rqx
	 sc1qUy2UFYASHH6ybF8L9CHfyzoJKy+prNT2caE5+17YDrP4iDZlXM+XYEIhbKF5iGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCp1JIxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978B606A31B
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 02:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8978B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCp1JIxC
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so11094665e9.3
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 18:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793847329; cv=none;
        d=google.com; s=arc-20260327;
        b=WrbNDf6K6JYKMUGx5330vjcx4f+SSePGcuZyD1JraSXKjK49Xe98VNAaiS12pHSCMS
         IfV6Ked0iObgugWItRPnHjU0u94m1Wv/OCxr3OUgSsAFXv/By0iPWQnlJa3XCf7Ejinz
         XQoWRauY1TeoVtEGvwpuf1nxviBIjjyhWgtyoVRGv1JiXmUhpqA/3eJ34d2mFZTmmU99
         pgIBEaTo7sSpWkioK+Dr3ayFB5KvTd5VZ/JhBxvG5S0xWhmW5fxg0svWByowTLF54oSX
         GFgIeEcvD6IHu+gbvyzZWnRkXk7S9L8sjXktj6prrp1XLMQqcjnFynDe+3zCYN4dyPlp
         UyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jR7loNAHPL1UfcJr49MgWtfYGIhpgreosCIZ48GmVGQ=;
        fh=L3aJusg48vGjkOitHtHOgZIssVhJsI7N6onyMkIaPts=;
        b=nBVC/3sPJgSRfCdOYmui6/HeROPavVizFqYC+u899acbXnnZFKjaygaL+5HhEASe4x
         ezw3X5v/hDHj94vdvZh1Wmxwd06P4yCmfvAk9E8JyEDFfVHsOLf/tWT5URkLWUTUtt4z
         sE3xxIGhBBagg8KUjLXltFBub6qF1fO4wowPfuZoSzdXvFO2TREi2uodsjO4ZW97pWB/
         2MHrhYGe9Ea9qXbiYhYv+evDfW/kzHBjPhlPqQt0t2nZ8jJm2hspOXXJ72UlUXQRC1nE
         BVjLXuczd4+KqoKTMRLmdS2BgSwoQZx1FThwQgQUosVggfel+aDjgsSdUWg42aTmbj/4
         n0dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793847329; x=1794452129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jR7loNAHPL1UfcJr49MgWtfYGIhpgreosCIZ48GmVGQ=;
        b=XCp1JIxCz0JiH7VJnEPqhrFzh7f2B3ku9NmKDzaa+kU1MTro94csImVUBu7SiXupbe
         bZH/HuvFqTOGINWY6rYdyQpdGarAug0MMkAu0GEbv5PMxqs57U898UepqTiEeRoDJvN+
         BnlM0vUl1nyks6zkS++X7ZWD5ETzMWS6dkgXWh9f3z/j6ItN9i53UUa+iS8TVvEUt1MS
         1T2niWLVZskoR/LOuTPqTPObNdL7WPHLOroTnv2esbgrR4qjuuJIIvEZhWb9kC82aujh
         VyFazFDBFq/IA92ONa7wUUf9JsKGAlYcrkbnGWBW8i80W6R5obtkEYdppm2YMH3xDze7
         Jl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793847329; x=1794452129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jR7loNAHPL1UfcJr49MgWtfYGIhpgreosCIZ48GmVGQ=;
        b=Ym42Qe5FcLzzQhHY89BSSCaMztVLcv2Iwqfkjr8eJWIxiRQeMJVmUTBSZHRv8UoymC
         BVFAbVBeFxfdG+OTCZ54d8E9mLzA6nzgd5YixfIBnyN7A2QlFdkcnwZi/Ez+j4uTI1ft
         aGD3VdtvBqoQdwRN1fptaPKRvHGDWH+WzTcsP9W4iQvmkEc48gIMwbTiq2NCnwZt3N5d
         T32gAWl9YNSe8+zxqncnu8LB8Kz7GOB35bkGxwwwcIK1CietOEMjYxlPmAUKPMRMBuu6
         EB15YokXgCM0Y1uBJQFQTVMQIh5XqyUCVHZw1a34n8lfRXK5M3yO1SGvfCq4ELdPk9gK
         pAMA==
X-Forwarded-Encrypted: i=1; AKwUvBzaYq0p3rUiL9ZMxZTQVqWyjyFHe/CgIRG59S/nFyU+ZbpYgOPWcWPP8rOrvCKatHwk8cs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UFBZ4EkSBNRVWmT1jEEfe53BnksfP6PuusnvDqN0bES/9Vr3O
	BOMqeThX6Y95djIPFCfsaPY+Ys0Nxac0sCUhZvaYogss1qJRCMiVU5NOg3wkpi3ZW3y9bQM3aUi
	BWimEClCg0sRPodB/x3dSg9n605Um/LekuEDGXYGFMQ==
X-Gm-Gg: AYBFou1/hnF1EHOeYTrgFaHYOhCz78DL5x5TNUVQnetGeeerHSHaF2+PN5bmueAQ+DF
	IpcXivsGFBzIKOo9HDRFM0MJjDTVOXpbQSunWej2mK65ykxTMIoArNrGH/knN7q+af8JNeIhQoA
	qcm9gmjB6/3siv4FMgjl2wGojLaYreGbil9KAGR7lCPeVq7IVHVRVP5m5kOJDQ0oa2vPwLFneTV
	UImdM04OT6u7wPrGyS1ym3KPewr/jqDiiAAkF05wlN0iPyr3Av0ST8/yQ+fxS3QKBktuadKvzAC
	5i9jNnfIxskGD/SV6HCM+bVJUOex2/qRGZFqCoP4uFAiXmgQyEhh7bMyNT0XMzIyCrDdZYbix8f
	Umyl40hFfL4tVYrr3EQqpWiGjKz6K6RZQUL6q7w==
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id
 5b1f17b1804b1-4ac175669d8mr434677375e9.14.1793847328397; Wed, 04 Nov 2026
 18:55:28 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104153046.965890-1-joelagnelf@nvidia.com>
In-Reply-To: <20261104153046.965890-1-joelagnelf@nvidia.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 5 Nov 2026 10:55:17 +0800
X-Gm-Features: AclHuK8fWNS4iqHr9EC6eqcHPc25Ps3rjrWEn5ef_l6R_L-fgVDB7DVBIpfqaWA
Message-ID: <CAN_Opa9t9gL3O2dkBTiHKHAnJCbUNOYBmQkzWevCFr8r6ypGhQ@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Track barrier callbacks in debugobjects
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joel,

I ran into the same warnings while testing rcutorture changes on top
of my earlier series,
so thanks for posting the fix.

Verified on x86_64 with torture_type=3Dtasks object_debug=3D1 n_barrier_cbs=
=3D2:

Without the patch, each barrier round triggers:
ODEBUG: active_state not available (active state 0) object:
(____ptrval____) object type: rcu_head hint: 0x0

With the patch applied, the warnings are gone, and 300+ barrier rounds
complete cleanly.

I'd like to include this as the first patch in my follow-up series,
since the new
rcutorture tasks coverage depends on it. Please let me know if that's an is=
sue.

Tested-by:  Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Thanks,
Kunwu

On Wed, Nov 4, 2026 at 11:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
> However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
> directly with rcu_segcblist_entrain(), bypassing the queue hook in
> call_rcu_tasks_generic(). This produces active_state and deactivate
> warnings for untracked objects when a barrier callback runs.
>
> Activate each barrier head before entrainment and undo that activation
> when there are no callbacks to entrain behind. Successful entrainment
> is balanced by the invocation path, as for ordinary callbacks.
>
> The existing n_barrier_cbs=3D2 torture test reproduces the warnings befor=
e
> this change and completes without them afterwards.
>
> This fixes patch "rcu-tasks: Detect duplicate callback enqueue".
>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tasks.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d5d060a5c4b6..a20db323612b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic=
(struct rcu_tasks *rtp)
>                         break;
>                 rtpcp =3D per_cpu_ptr(rtp->rtpcpu, cpu);
>                 rtpcp->barrier_q_head.func =3D rcu_barrier_tasks_generic_=
cb;
> +               debug_rcu_head_queue(&rtpcp->barrier_q_head);
>                 raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>                 if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier=
_q_head))
>                         atomic_inc(&rtp->barrier_q_count);
> +               else
> +                       debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
>                 raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>         }
>         if (atomic_sub_and_test(2, &rtp->barrier_q_count))
> --
> 2.54.0
>
