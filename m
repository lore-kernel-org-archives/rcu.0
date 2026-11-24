Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554529;
	b=DOpiT1Tm/+yWaTMEVRS7kd+2Us4ACJnVZgKdJXHofBeyQ9AZJgfgA66CkAN3c/4xm9X9
	 PyCXoAgcBdhabB65WdzOdNon+WikGn++mMqN300mBlqWrgiQq1hWeaOdnxYJC9UKugeRe
	 pe9BhtQUMXOZ6M2qUY9wUxJ5aK4jlwOelfGBpFV91i2wc+rqtq31ztJqt5HRJ6M7AKAcQ
	 QJUjF4A8okJ98pNMgm9X57yji1lY5p+9qlL83voixlrC+A+Zrujkbj5Jj+/78DbNQn8w5
	 R9dcZlaC9vzgwcnXWA2nvxv5VHRk5cf/Mqr+9inL0b6brE0D9nrBD+k96emPeI7ylMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
	b=mfVN7yi1tVI0UN77DF+ZZP9avvafbbVC4gaZyacUVl0mz9ZWfjhXhGw4VLSDBhSJdhd3
	 QjMS2I4cpAuxy8DUTK051cVw4tVyNf5859fVbiFu4XPRYRhPBaaN8FSRJE7xmYZEVWEuZ
	 O4E7+/DriXIelvnf7n1NiDGxprCQAPqAEm62M+ACmIHF1aY7u9KpAEsx+r1TgodDnCWAc
	 ACeypi8UVpN7d8wzWuqroNcjI5UMwtsAlYdToIoziWq3euQYCnWoMJ+rvsyM+5XyWDB0p
	 NKSxCwGnS4Qoq9fCvVKVsD6IVnRVgAFXXOv+FPOVuCZN86SYCH4CetFP5bCMYBfyjBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vaZLIGHm;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F683606A32C
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 21:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F683606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vaZLIGHm
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso2014949b3a.3
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554528; x=1796159328; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
        b=vaZLIGHmdMLAeP3hCfVR9M8r2dq696vSeB4GJOOrtdhFWSfxRDHSp1L/iS5kl9gnqK
         zafbDaAj3hsmF2ZlXb+CBXrTsZ6cNqa4QtOdYr07CmsRMC/1IWK5KeUiqLkORuLebgGl
         WlWCn6XgFxNszcEVP8RM3qo0rFhvKeXH2ctH/8w7ru1RftiRxUgyw1CMKde7M0TO9Iy/
         ssaXEtzVj7t1AGk/GiKsDAEnqAIlKsqq3PjyeASMmlReECw33NlJwf6RKvI4DhXx7rnD
         u0r43telmLn3URSUiExeY98/+qDxPPi+L6keQbNWPINLuH20QbmxD138h4LcqdL9VtHY
         5ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554528; x=1796159328;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
        b=KzT7U/yDrvdp6ITrBZ5B139/o2K+2LVXl7qCUalO4LhIxRc38pZgmqpvVacpG4SIAY
         N7aDR4pArMFyV4gEYVTZ288t63gnL6f80aaHR2CKbaSaAQkeuCpP2DIOokRDchKvgoYS
         g5EVSCYJgjo/5TT49FUUnj8CGzaoElgerCJypVw3GlZZ/08O12pKXPiCCToWj9zU0Cyy
         TJp/JD1o7GoIJHLzO3wXhVOvxCQn1aWX/hE3H3IW4TYf2cf0uBwJaFj3m7jLA6n4nHl+
         3OORyDRaHpqufVqvgJ6mAIcer0+o32Gft7NQ6jiMB95zrj0grS9umzc+HpMMppi9bsYP
         x9bQ==
X-Forwarded-Encrypted: i=1; AL+hErFJBv3VLmjcsCC07yVzaVEoxvSVahgb2WWAk5KnC8W1u263hA/99YPmmfhdtmqsNycuM8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A0lwIC1C/Ml0pyqddZJtUKpcb3u+gJpjipWxi4AymW11lUtMP
	+BoSgfvnM2Zk+XM0kpTsFWmO4iy8wS8LvyaEhy3R4irWjuoyo8+ggQOr
X-Gm-Gg: AZFdTZdWv8fGEKOLvfNPgEv2jKSfuWV3CGaG1TqH2gfuis8BUPrzsrR4APKtIchq3Uj
	1QOokilH/cBn9yiEjHQbNxFGM1Gtw8uWXVEfgQ/VaCSi0+7yfJf/o7mzEc+ZycpiXDqKn2OH3O9
	ZWLDM8qjPaQJtWOyC1hMKGiAkNs1AhKJW1e7vr4qC4rRz0sdZzZHgi9wYHEG0v3l1ao4ssmRXN7
	6IW1qmbtRztHzSf9yQL6MtN3DuNRMUq3GEQ6ea8TIe7NBzaWPBCqjXKkj6A5wDlBKWrQsKU2Qr4
	xhTSK+TvQth7QbHNd+jDB9TpXk4u+DdvA3cOnZTsGPOZklb3E9l13M63YqRYa/iMcwlPIVHGzGD
	cxPMLHbpUqmGfDF68Rko+XZikFqJloRvgceh0WH8wGK0Cz8dO91DvrAYZ5HQJrXlQuw1giPutJu
	pKyBjFHEREAUfcrm24TdWv55/lCo5AopaZWmIgAy0GlxhqPdJzRoImbgifzxsNGr+aSA2NE5ULF
	GS54riwLvZiJ/vsm8b03DWjWbY0olJRsGoOE2iV7EUy3aHhPeLdyoYFm/Vdg3xeOwW+DQlDVQzA
	CrYn1TNFx84I1vW8Y5lZXB9Q4GmKpC2g99GVxCqTBjTCK202dsKnVV1AKpCkfG9Ss24F5lKr9cu
	YPPDgBUQfOPF9dB/B4l7VlBTfUkaiIJsbJQ==
X-Received: by 2002:a05:6a21:139a:b0:3fe:81b:5194 with SMTP id adf61e73a8af0-4014e45f92cmr15775068637.62.1795554527700;
        Tue, 24 Nov 2026 13:08:47 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm7606443b3a.26.2026.11.24.13.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:08:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 21:08:46 +0000
Message-Id: <DN3QYI65E4KR.27D6XBG0SUWVI@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>, "Boqun
 Feng" <boqun@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
References: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 10:56 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> The BPF trampoline calls rcu_read_unlock() on its exit path. If the
> task was preempted in the RCU read-side critical section, this ends up
> in rcu_read_unlock_special(). When a BPF fentry or fexit program is
> attached to rcu_read_unlock_special() itself, the trampoline runs again

Not quite. need_qs and exp_hint set rcu_read_unlock_special.s too,
no preemption needed.
With fexit it recurses on entry, before the prog runs:

  __rcu_read_unlock()              nesting 1 -> 0, .s != 0
    rcu_read_unlock_special()
      __bpf_tramp_enter()
        percpu_ref_get()           nesting 0 -> 1 -> 0, .s != 0
          rcu_read_unlock_special()

> -static void rcu_read_unlock_special(struct task_struct *t)
> +static notrace void rcu_read_unlock_special(struct task_struct *t)

It should be fixed on bpf side. Only the bpf trampoline recurses.
ftrace, fprobe and kprobes take ftrace_test_recursion_trylock().
notrace takes the function away from them and from livepatch.
__rcu_read_unlock() is in btf_id_deny for the same reason.


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed..0e8afc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
 #ifdef CONFIG_PREEMPT_RCU
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
+BTF_ID(func, rcu_read_unlock_special)
 #endif
 BTF_SET_END(btf_id_deny)
 
Pls target bpf-next.

pw-bot: cr
