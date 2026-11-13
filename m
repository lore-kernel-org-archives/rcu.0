Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794531701;
	b=ghY0bwCFeQSwXRTcdC9zy7ukAlqMaDoyUqDDoHa6gP2ro5E+pT4Ub/YC7mV5iEIhIl7t
	 nIUheL0/JSt0Sra/Gw08xkgyfvMeDcMYyIu5udAwJD4mBfm+b5EsKOef+vUcXN499XfoP
	 MErkjUgOvgC0f4L1Dp/G8suoJ+54xVDfM25TwGoyAwruvd+LjlcBTvLzJXxRoTi1GQxd4
	 R0ej+YYUqQEdYJH4myn+aQXs1s1ycOPrN6Fhtdc4Bg0XshoYvNCDPe4S5weHg/NOdKlm3
	 8kRpG7yBsdGU4Je55WUgPTUkq/5luqRfqAui21N8ZPMGpa59UQjeVaVPwsfT/MZf+Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xsqNy8x4lmXAXvHwF9gkwZoG25xYnfN0MsYpVbWeuyQ=;
	b=e8VpRCXjwZausIAiuaJpJM0ba2vVE1IxwdXFljO6cxni71ViXISyhSJPQnUi7yekl0FF
	 BgflUjpdC1f/5y/Fwf6SiENMJ+lEJezuxD5hS7K+F7YsaQIffjO1t4uSmt+Xv44GjbNdv
	 8IB7mCMD5V9tDL4J/KvVeSI5J/F+BibVGsmJoHYMfUdX3YgA794AhlPanYgSSJ/OwOxVI
	 1YB4ffyAqp63uXO6liG7/isInTFW0xnjpchDBCCkrZ6hxjTDMMFUn1sguctNXWm/68fIV
	 xwJk/k7Ia1oBbX9+NjJVH8SDZqfiPuSIzeeMSgJSl8vriaLliSgPCfM4Ele3L+2SZZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=joelfernandes.org;
	spf=pass smtp.mailfrom=joelfernandes.org;
	dkim=pass header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=G1jbsG+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E3606A31C
	for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 01:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 027E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=G1jbsG+S
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so2679495e9.1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 17:01:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794531698; cv=none;
        d=google.com; s=arc-20260327;
        b=CEhZNOJ+6G21zoIekHZGCNp9qg/1hl7FPE8Jyhma1CWWfjh7tcDleSqGdQS3LTbNpS
         7GTmCAeOiJgwi2Pgdso1xr9/LkbL62cMEV0OPLw64dfRakBC2IDNJmidInOPqmo1U3pC
         3P1NH8k0kMZwti+6qRq5P7W3vKwcgNuRa9+BiTgYJPH3p2ym3J/fK+0gRxQ1w8Q/nUaw
         eV9h3TCpYbsqPPartNjXMPrCS4YCf5g+TNU3nlITdYmBNICC1RVozMf0BEocymz4d/Rt
         44+FO2vknCMHnEbvhYEe8UbpqfEJorTWdahj+JHUFcBZrK9hOHfWPQOHmBE9wtbO/tMi
         UWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xsqNy8x4lmXAXvHwF9gkwZoG25xYnfN0MsYpVbWeuyQ=;
        fh=GVZXdus0SNidJPS1KKf9pH0EgBum/X6OmJrriK22Kwo=;
        b=if/GrpdgdQmE4FtHvo0iuBi/fp2vq+tc4fx9XkQS8JAVmIlL07r8xqROR/8YWHHkbR
         0jJEhRWhaUYlMuyk6/xSmY21MZGkjOg0B/qLSnBeYNdnCrVGC54vRfLwi2c7ILNTWxWn
         eONaGu3keoVkJZ8p3X5kEd/vh/VAJPnhJzdBnvLG26J4N3fd0/3nUeA04b93JqDsQjoU
         khBm2nHVYM3Pv8zYRu+BhBy7wOtFc+kvtsg9l4VxNzFFR3zQN34pXYKj+0Twr3pUXUXE
         MmjqJg3ajhQ3d11WUWF8nj/PJd2bOSV5twkYaqHxMLGkEC+6I08WC5li9qzH+pc81OTa
         mhyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1794531698; x=1795136498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xsqNy8x4lmXAXvHwF9gkwZoG25xYnfN0MsYpVbWeuyQ=;
        b=G1jbsG+SSau2XzDeW1OBYgcZTEKbYsSnIFjCz5jzxju2YOgwgfGuinOztdcmDgtqWf
         gs2+QeCPNvtJ/fn1ygL0g7bEy34oR7Y0N3LEL4YlJ9fDk3GdFupL6jpH7jf55PP3vmfg
         a2MC+9Pbb3enm3e5qIZT7H9J+PCKaYqIYCk1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531698; x=1795136498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsqNy8x4lmXAXvHwF9gkwZoG25xYnfN0MsYpVbWeuyQ=;
        b=JRuphpV/YYoworP8+7GxhJipwhgZyQg/+gtApndo5+9Uexk4pMwheLXqn6h6b1v+KF
         3hyd0JnMEGxhTVK7D61SBhd9mvxgD7k0Y8JyWPUc/9L1QTIhxut+4Pmdp6rrIKLi6TA5
         ruJ+UjpA5SMRuIsUKOHkCfw1z20cNAstqR0Ap28Zhlovq9d0xhJPR0IegkKGKmsiivJq
         5DS7oGMIP7sgts6eWiQX8cdNH1Qrxu6St8pd778BotprVeAK4RCDLs5yiLv67FIWwsny
         0dVV5oipAKq7ld9E5hpcuS6KOFh/iYr/6oEDSD79E5oSuDkbJNXwjQBT6ZyTqG8Kl5wm
         Jtvw==
X-Forwarded-Encrypted: i=1; AL+hErGSBpbyXzJOBf++xe6LB27pbwH3goHJcQ75ZZm4x/h4AsvhgehNSIeljO0W4i43lKL8Fs4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T9RVgbXzfJX0W7phOSxIHhtNJqfeSMJtJN+CVO/z6TxFyPygR
	QNN8h4mjkfr2NeFaA68zNv6f1uX4wl9VRVb4p4eRESt7o9IO5M5nn4X2m9YVFCLZPEQim1S6e2f
	9OU79f1zeyq0VdzdETpTKk4kR6IwWv6/XEOCDBjBOoA==
X-Gm-Gg: AYBFou1bwelGeGJat/x95L5/r17ugtH9i5lzZD4VqzZ40kj4S1e0fJSGHcbazo0SiZ6
	V0Qf4Eil+byAWwmKBPdJMfNb5nPPPjvBr2uLWszddk/++NN+JAhHhqGSnZnA6QiIYiIc0nW34xm
	DhFbWcvak/B9lt9mu1Qw7wira0V1ofiwGkTbYar++Hpw+CYAhlaiQwaHWrkUDwqDmYuVftPc/B9
	zYztepPLCnR/pDHadEclTUkyqRNp1KeOqf+DkawWh7y9NCGyBa2QQAA2ELSnO8nIKtwmEHTnRw4
	Jb9v+aopnry4d5IG3w5ZbdGMXNEVuUdEkMSLl2XhqI3CL9yLXdl9JI2N/ghbrloaTos8TYR0H3m
	ADrFRk92y+dwyirLm46msQLwUz62CiycYT3GaF3n+vOFo6tzkItf5kAdGPn0=
X-Received: by 2002:a05:600c:8b8c:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4bb55a7a460mr17515855e9.19.1794531698338; Thu, 12 Nov 2026
 17:01:38 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113004946.2758197-1-jfern@kernel.org> <20261113004946.2758197-5-jfern@kernel.org>
In-Reply-To: <20261113004946.2758197-5-jfern@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 12 Nov 2026 20:01:25 -0500
X-Gm-Features: AclHuK-BlMNbouTRIZA68HB056zVMIxCfaWWRZW7PBno_ghygL1wLUmiCANRO7s
Message-ID: <CAEXW_YTY1rjYH8FwvLvc1JbOQYDuXTP7BEE0a6eoRfu+-ZC6-g@mail.gmail.com>
Subject: Re: [PATCH for-v7.5 4/5] rcu-tasks: Use pr_debug() for callback
 contend/collapse messages
To: Joel Fernandes <jfern@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org, 
	Song Liu <song@kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:49=E2=80=AFPM Joel Fernandes <jfern@kernel.org> w=
rote:
>
> From: Song Liu <song@kernel.org>
>
> Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> messages by default") added the rcupdate.rcu_task_collapse_debug module
> parameter to gate the three pr_info() messages that report RCU Tasks
> switching between CPU-0 and per-CPU callback queuing.
>
> The kernel already has a mechanism for debug-only messages that are off
> by default: pr_debug().  Use pr_debug() for these messages, and remove
> the rcu_task_collapse_debug module parameter, its documentation, and
> its boot-time announcement.
>
> The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=3Dy kernels,
> they can be enabled at boot with:
>
>   dyndbg=3D"file kernel/rcu/tasks.h +p"
>
> or at runtime with:
>
>   echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>
> Signed-off-by: Joel Fernandes <jfern@kernel.org>

Btw, even though I included this in the 'for-7.5', I am planning to
send it for 7.4-rc as we discussed, so please ignore it in this set.

thanks,

Joel Fernandes
