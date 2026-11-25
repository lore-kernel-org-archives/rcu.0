Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626881;
	b=PU5xyRt44UeXUxhM4PLciHrei96/Yl/wk4dsSsTzhbnXFS01gu2lAeieUJrGHwJIBq8o
	 hHWjNha9OrhojaETV1H+HzmDHWU8eJR1HgYaSEcQO9QJ6MJxaTas5IybYpmS+VsCtL+3K
	 S48tG50nKRHY16fl7W3Oy6dSRbPYy4GN5yKaWV/2HQa9T/CRIdLlHT3KjU6VgdZeJi+Hb
	 VPmenM+dfbk7leAWwpI3eqs4kmvn6hmmmKLAupQH4gE5Am4wHhclxCU9VPzEwMwQlB0O9
	 KOhf+dcHsItzCCAP/WTARc3NA/J9w3Uk9qipXlTkGmeVcpGpfw9NETTJ2pbjHP3/W4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=iTPMEVE+n66Njmd3pYh0HsF30+0zreeGETk6kB8++tA=;
	b=C5xlog/VMNoj7cWity1p8d35RNGQDeBebi4kz7D5WbEVtwQl50YnD/6wES9EkCKdQlJj
	 mtEvlTdNNwo1Kt7rHoFZyFxD32zEkrefjDv5lq5tBixwbOhpQEcPrUO4V66wJ6b2AwhlR
	 nh+eRvuN2URYoHJNqqFnoa5pkL1h7zDDZuxggzGKXWKNqsC+dMshbIwGOsljeGF/dyepE
	 WOgO8IGEFr+jeTfxg0ZPUSifijj4hUyXsKRQsnGWSyMuR6VMPD7DcrPuBtaVkGEpFbX8M
	 v+2iNqxU3KYRMNA4FDAabtyjPMskf3sNOzzMdop9fKP2fojBhPiQp4WxNY+WDv9wRkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZgKg5cU;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BF606A31E
	for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 17:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA5BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZgKg5cU
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3192024a12.1
        for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626880; x=1796231680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTPMEVE+n66Njmd3pYh0HsF30+0zreeGETk6kB8++tA=;
        b=zZgKg5cU5ST2xEZeWQcxtNS1P6FsP1uxfPoZRI/YYjHXv56GtDkSMlOkfVbZB2HQ2L
         TmHMPLgxRV4vzpUKL2RjVgVgl6GlqWgkrLokXcM7wRuICuKdbAMxQjOAFIRwHLTabgoY
         tiYO4crNdoCWnku9XZryPf4DYSi/3B8pxVtuUMmDy4P91pgzBasZ5j7G4UGJv54uc4bm
         rM/n7ImVjv2l6TR0v5qSkRLc1GVQq7+CZwM4PEPrC82J2mUWwxsekgic4ILgj5Z9ziZ1
         ibZ/khEbLhkkCIhjd9tuYnA5jOYEu0cmctzPeNqmG0jhDHXOp13pUdYGxbbyzh2TIhZi
         emEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626880; x=1796231680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iTPMEVE+n66Njmd3pYh0HsF30+0zreeGETk6kB8++tA=;
        b=M4PzIO8xfnIYmg887ToExh8HsfEyz/LNrsVi0RPofw0Y5jsII2RRmO4IYwMw7SLeek
         kvjzFIu5hhoBkHrWKTwKCEPAsbKl2rG/6Ho27gcRc+whotcPjIK+rJyDn20RV6ku6/LQ
         QUwB3JEExXXOoFXTjtdf9w+zQyczpzASt/wvnAY2qx+pzmpy1Vfw8GY0cpAe3EmH+1pS
         5MVrjbvZAjAodpXvD2XrqNdGX5tnDQnQKV4XLi9x6tdDnonx0+I0Yr6yHUtgRgL3MU+v
         EjMFenHgPXAz2TyvLFB6P8ntdOwI1ihmYdw8ELieuHGtc1aG84HBMAGOR83wl0Nmkve1
         WuwQ==
X-Forwarded-Encrypted: i=1; AL+hErFcLUWGxOnrg7IP/sCxcUf7Qlr7x3udagCRULt4rMXVBnigPJYadH6Kh6t6xDR4pJd5ZGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wPMBlk1kyrWH9fXP3rGw1VUfiamCQ74axCQiw29rQNIuGMkam
	kTZgCY7aZ6PwNniFVhA3gWGce5Iz7h2fd7apiKhF8yhMpzfxNcpJqAGb
X-Gm-Gg: AZFdTZfljG3JPX0YzpOSLOzEoR4pYG5jzoew4OpPQtChRTEVHc8Eq7lhbb0/DlRwlF0
	FCtFHRE4YVfIXE2AhuzoLPEhxm3qAqsOWqsCb3PhfWaGT/plb8MOiV+Z8mk2s8mjOXUxixqZt0b
	rY6WrOsnhBfnW+bikaXyHxSR6DfsgYj1dzeg7WmKhUxcAohESL88/yKsouWlovKpFRgG/xz5gAF
	yShf3GeU78VZCeABDhqh3Sj+4e6zYj/JTOy7k6q46rpgaoOy2C7Jb+3j9smPFMpKriGdTbtpPex
	OQPVoh4KWk8NBym8VaPJZi6jdzkSm8myVZ9qn49yFC2KF2v+gzMHztxjJ+2iowU2A2gZwfnnLwz
	WT52CZ2HN7tq8MUCm9i9KOV/OrFbpbcj+XmIbJkOy1ni4uNfLa6wnPe6h85BB5beXg+lB/AUyBB
	saY6oWqf5PBvP2eVSTIwu26Grk9wpaPEuqoB6SSx0NPkxap3PFzV2CZ2BkY9nw3aoueWFYct2Mg
	l++EXrcXXOdcQ+X6S57J8Ww2Xm8EaSmbWv7uTbFaq9MeJaX0oCtcfHcvn8jUN37EbjD2xBFBdUo
	MMYS2FEqUQotyfuQHGaeh1+n8GclYQg6NXQc8dpgQXwGVQo9ifJPups=
X-Received: by 2002:a17:90b:5543:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3b41c8d9bb8mr16873396a91.19.1795626880239;
        Wed, 25 Nov 2026 09:14:40 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm31583644a91.12.2026.11.25.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:14:39 -0800 (PST)
Date: Wed, 25 Nov 2026 17:14:32 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kartikeya Dwivedi Kumar <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf
 id deny list
Message-ID: <awcXeA5xej8w-UL7@srsys1>
References: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
 <E03F487E-3E0D-4FE8-9BD4-F2ABAC7213B4@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E03F487E-3E0D-4FE8-9BD4-F2ABAC7213B4@nvidia.com>

On Wed, Nov 25, 2026 at 08:18:51AM +0000, Joel Fernandes wrote:
>
>
>> On Nov 25, 2026, at 12:54 AM, Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>>
>> ﻿The BPF trampoline takes and drops the RCU read lock itself. When the
>> outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
>> calls rcu_read_unlock_special(). If a fentry program is attached to
>> rcu_read_unlock_special(), the unlock on the trampoline exit path still
>> sees .s set and calls rcu_read_unlock_special() again, which recurses
>> until the stack overflows:
>>
>>  BUG: TASK stack guard page was hit at ffffc90001657ff8
>>  ...
>>   bpf_trampoline_6442575622+0x5e/0xac
>>   rcu_read_unlock_special+0x5/0x490
>>   __rcu_read_unlock+0x9c/0x120
>>   rcu_read_unlock_migrate+0x93/0x220
>>   bpf_trampoline_6442575622+0x5e/0xac
>>   rcu_read_unlock_special+0x5/0x490
>>   ...
>
>Can this problem not happen also if you have an RCU read-side critical section within an ftrace probe on sensitive RCU functions?
>
>If yes, I wonder if we need a more general fix than BPF-specific, such as using notrace on the sensitive function.
>

I don't think so. ftrace, fprobe, and kprobes take ftrace_test_recursion_trylock(), so
only the bpf trampoline recurses here. v1 used notrace, and Alexei
suggested fixing it on the bpf side instead:
https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

>> With fexit it recurses even earlier, from percpu_ref_get() in
>> __bpf_tramp_enter(), which takes and drops the RCU read lock before the
>> program runs.
>>
>> __rcu_read_unlock() is in the deny list for the same reason. Add
>> rcu_read_unlock_special() too. It is static with one caller and gcc
>> inlines it, which leaves the entry unresolved and breaks the build with
>> CONFIG_WERROR=y, so mark it noinline.
>>
>> rcu_unlock_needs_exp_handling() also runs with .s set. It is normally
>> inlined, but an out-of-line copy would recurse the same way, so mark it
>> __always_inline.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>> v3:
>> - Mark rcu_read_unlock_special() noinline for gcc (Alexei)
>> - Mark rcu_unlock_needs_exp_handling() __always_inline (Alexei)
>> - Drop Bradley's Reviewed-by, since the patch now changes RCU
>>
>> v2: https://lore.kernel.org/bpf/20261125040106.2200628-1-rhkrqnwk98@gmail.com/
>> v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/
>>
>> kernel/bpf/verifier.c    |  1 +
>> kernel/rcu/tree_plugin.h | 12 +++++++-----
>> 2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e7013ed8cadd..0e8afc0250b5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
>> #ifdef CONFIG_PREEMPT_RCU
>> BTF_ID(func, __rcu_read_lock)
>> BTF_ID(func, __rcu_read_unlock)
>> +BTF_ID(func, rcu_read_unlock_special)
>> #endif
>> BTF_SET_END(btf_id_deny)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index ae5d21bae7bc..40996dc29b28 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -689,10 +689,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  *
>>  * Returns true if expedited processing of the rcu_read_unlock() is needed.
>>  */
>> -static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>> -                      struct rcu_data *rdp,
>> -                      struct rcu_node *rnp,
>> -                      bool irqs_were_disabled)
>> +static __always_inline bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>> +                              struct rcu_data *rdp,
>> +                              struct rcu_node *rnp,
>> +                              bool irqs_were_disabled)
>> {
>>    /*
>>     * Check if this task is blocking an expedited grace period. If the
>> @@ -745,8 +745,10 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>>  * Handle special cases during rcu_read_unlock(), such as needing to
>>  * notify RCU core processing or task having blocked during the RCU
>>  * read-side critical section.
>> + *
>> + * noinline: btf_id_deny in kernel/bpf/verifier.c needs it in BTF.
>>  */
>
>Please drop this comment.
>

Will do in v4.

Thanks,
sechang
