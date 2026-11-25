Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579291;
	b=jMma5yKqS9Ls/LWt784IMUvCoZPpde6SYK6j39whglQrX2RkQbeoBkjfJSU4KBy0f0YJ
	 UFBAsGDpymykf6r5nPZW473hYQXa5EHVumZO2JuUihmnqoM74o4r1Gn2F1pfNVvQqMYLA
	 WmBgDiuY4kFpY8MhI3ol7NXrHVpklsTV27d/vw89JrlEsKIO+MB156/u1SLz9ESlsXnYm
	 VrieK831AKUrd+0mrl3VPwoowpECuhY9QOUnydZSdkWVBbuPlPfjvllFPoeGw7bQ/sYEo
	 VVphwGJJjitXvHbweZZ4oQOB00DWU/Fr1vWgigWXAytePNoibp4AKdk5A6SOK8wqhHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
	b=E8YxJ71TXddhqqWMaa7lQWvroo+8PjuUvuMvRDgxy0yk3v3ex4+kDnm9NF3v46h+VX8j
	 HCAgJK5TJFYYYhKHYGvjuGuzAZMuc1AlX+NYmVHz1d5dTp4SuHZGx3cRjWRePYqPy5oI3
	 1ysXOdwPt7QnTwvX0iyuQHdPy1+2huis1KAaWnctBhyd3Jy1jdQ8Nw6QFDG3OjvDKdDYg
	 zdNJsmLFoWOmZaU3ZZIAENpnUyAnumxcnLxY5PxtPvE1sRrzd7uVIooNv61JX1KxKwQV3
	 M65mFNTnFarTIyrYDY0cnlJU+wQdTFLo0hMhaIRPUfrH6LUZvBiDc+kZpTr0a0b9GRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZT78E86w;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509E606A321
	for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 04:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8509E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZT78E86w
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso5251757c88.1
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 20:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579291; x=1796184091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
        b=ZT78E86wQe3bgt5nxImE5+aVBs7YtYvND66iVpyhs1/A9gNHPkXnPWIFJTwm6HEtmj
         k22zmdcmU3/DR92JOkZ2XTpF3ZzjuPFZPvQXXi5LlK5ozQztsKXJhclNqRSxc7u1JBRR
         hVstKwp7XzzEaBvmewUFjLvKvJuVPJu+blAcCzgfH6BFOH46y1K2IdTuqq5MlS/dXXKC
         vrS9A5jrqkfSYpZnZWh/YTCJuv4YiBCuqCIaM9s1kiz/manx5VCl97QbOrOsuMUjp5eh
         ZKEcl5P32ExOK/pMkfDMAXjTwxs2MMYhaYTIqZejtG9+YDkt8fJ12jYor+qYuawzHxcs
         CG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579291; x=1796184091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
        b=l2tY5gQdCPq/lquDAo359CvtSh/Qf4SOwCAz454IV1gBdyxcmotgcs0T4uvad10Y4u
         C4Ek6rWPHUU85HmJQb8kTUGMree9HKPYENqNaSbajYlqMrWju97232wWezWCOw8V6fI7
         Sp4yP6ONT4YvCxTKfw50MVTnXHeqZYu80RBnDqz57pL9XlhjQ1EdPoTuyA7X1xKsdhDM
         /NlHQRLC+yVe5s22fAi/85z2cDFmq+FfvebJWj3KbSron0w2s+1hmwdINnxqUCsOohY7
         LNYPBbcfQFuJtoDvR47AbUyrgtHRCUVoRtXF54EROlPYtrSnuY0EtT6THw8C7FZwuJi7
         TJXA==
X-Forwarded-Encrypted: i=1; AL+hErGVKV7L57McG+vyZiXzkmIA6GuQszqUdzh280/gpoINYEI8P1289silplNJRwP+gq7dVLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kMsWh9FJVnCrjmsAVOVvKbmgxQiC23b4Ne2OhG7s/CJx2k8uR
	rMvUH7fRbKzsksB0vnprDb7V7gkF89P0nWmnjWQC5nH51vfasKCEiENv
X-Gm-Gg: AZFdTZfmpkPwM3IRlEnrzBOPXtv1A6LQXhPpMP1uDU+KyooQVNYSSAoBeViGvFWh1ie
	ygw1+Qa7X/gY3/vdRDnRU9CMafBIdQmH1BQnt0qnrx5Ik0UCwKzdISYZ5als5krOKwkoXsKY1yq
	BpESoPfIQEK4cV9kNX50OGzTvAKyoaia2AyPoqRA4tzYATTyJry1F1QoQ5BXSAzTir1BYMLtavi
	LsbgMUiEQrafzsFyd+BP2vMQLZcZqYvfuDmoXBkfGVGXsJZ4AXd4YPLBxmTlp7ZR64rLMnY3wsx
	E7wR0xg/9llwBU/jCHyEOAY010ZL21F6bQ6o+ei44kJr1/ZShUDI23S8/9ZVUKg9Um19YKSV/Cd
	9HWc16JKCVv/hc4AuRcTMmJKc+MIeyaRtWNy3xBp2JuRpE3WzPDGsN5psgmCD6cbXm55StgNwnn
	O2r9vMy7fH59KeHUrktWzd23dwn4rB0mS1hC5e5auS9M30vdHUaCQ81/TF2v1S1qfuu/5tOecy5
	rzHOs2raKBuO5D45U6c5Od2fXeE1MakQQyOIQx+wkZSqn/4dVwFcO/ZfX/DqKP5d8GrJ11TCK/j
	X83Z2armtN3DW6NI2hm4fL9CZUrhvM02h7jpIbjOpA3KZy+Y246yvlFyrgIUk6FGJw==
X-Received: by 2002:a05:7301:2419:b0:367:185e:867a with SMTP id 5a478bee46e88-38571027a5dmr18690085eec.38.1795579290373;
        Tue, 24 Nov 2026 20:01:30 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm19892400eec.27.2026.11.24.20.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:01:29 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Add rcu_read_unlock_special() into btf id deny list
Date: Wed, 25 Nov 2026 04:01:02 +0000
Message-ID: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF trampoline takes and drops the RCU read lock itself. When the
outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
calls rcu_read_unlock_special(). If a fentry program is attached to
rcu_read_unlock_special(), the unlock on the trampoline exit path still
sees .s set and calls rcu_read_unlock_special() again, which recurses
until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

With fexit it recurses even earlier, from percpu_ref_get() in
__bpf_tramp_enter(), which takes and drops the RCU read lock before the
program runs.

__rcu_read_unlock() is in the deny list for the same reason. Add
rcu_read_unlock_special() too.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
- Deny the attach in btf_id_deny instead of marking the function
  notrace (Alexei)

v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed8cadd..0e8afc0250b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
 #ifdef CONFIG_PREEMPT_RCU
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
+BTF_ID(func, rcu_read_unlock_special)
 #endif
 BTF_SET_END(btf_id_deny)
 
-- 
2.56.1

