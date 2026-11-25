Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581890;
	b=fgIPNFZpfBE7zHNs3kqQEDsaIKRGeKg2af2Y+ArHWDZxlC5CovH/Tz8F97kWQSCXNYa7
	 5yzbZ1hDW3vF02HOkPnhpRKVn8h0gQlIP75oHJkZS7vm2G35D1ezfDRNfC7OuzXTlicog
	 Yu7y4dE2DVN9GR48nDGKCvBJkH01JbVar19rdGD/6tsVWQqJ7WO9ciUZ901pUoY86YDLs
	 ZYoj9ILB5uURGcih8D6PzNDgLPRom+CiAPp2pWLY/m/DBA7Vcyrdaj5jaaUZSl5uKsmOx
	 sKI8QgXBdDBlQtfzakR8NqlgUMxlb4we3isxDR0eCpK4CSyLc/3xn9oNAb3/km2Eefw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
	b=nFFXqQHTIpQ4fKc0XGijvtdaeQRzUwF3YK/YL/wle6yYChVcCxrQbeTl6/RTIIddoeJA
	 k1hQ8j9dvq+JTD8nyTFBn36UO3ZivSdOu/7pKoHwPd0R5rX6fGhwK1AJ0pZ5r5AYbGtjD
	 L9Soqfh9SgnEp41JPDXqQtdtRA34WxW0YHTjoKds0w5zLi2rhYt3EB7ixJ2WPZrH/ebzp
	 dx5jKmgsO7GoFhajsL2IA+y31pqQH9aWJGmBOiRZ94IDBqeLpztjWevz5DxrqzdziLwrQ
	 ey8yj+XFoSkpI0PR2vpo5xh45FxAONTVjEhuj6rfuCldoh12kqkPI45N6tFLRFoHw4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TMo/DuID";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64046606A684
	for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 04:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64046606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMo/DuID
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b402824d07so3597247a91.1
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 20:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581890; x=1796186690; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
        b=TMo/DuID8ZXu89TGA3aapdoCBdFqMqBHps+wl2gdkOnWevp5ELngUw1u2D61AW34/0
         dzJ4bqPKw09NcZ4SqqvToMQ8YqDZHKil9107dPmmqOlAykABlqiPsmrJZoM0nOcnGLjB
         PRPCF0q0QGVBlacBx9v4yYi9z5SYmuN27LTMgRr6NW5VwZuHQxwiAvfmwHMEIy2fB9mA
         G9tdb658V9bv36IWLax0+zmZNT+Cv8ZfcdUGz650T2g7vuDeHsic12YdFBY9XHkbjkvM
         5Kz7QJrtfYdwFlXPgF13Puomd5/qIu/ZpcKxgLQA1r5WXyf+JdxsfcsJABKHmvy8psgs
         Vx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581890; x=1796186690;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
        b=g9QnurvHc2eN6Jveywh8HOPatbR3RL+xt0yCtHkTK9VpEj0hjmxtVrLs6bT5wllZ0E
         8V6zedt88FZ3nD+RiOBM60nm6kKGh4ngSKqPd6Aepi9CNtd5sjqBdzeFkEClSURNGzty
         cqjwUG1EbEqNG4XlXgM80N3NVThxC3DanhrMxBinbr6zTty6XO2wjSYtXDyUOkITRpHd
         3L8ZcbWV1gMvv9zirl0+8IvahKXEaVv/RhsdKUA91VrsX8WTgeWy8KxBkuU9wR+scplN
         /Kvj96CwAUe5/Nq2LQ7sjI1aIvXpyo7l04fsN06vx28PyxNzZQsXDGlHJPtGhb+QjyLA
         Bmtg==
X-Forwarded-Encrypted: i=1; AL+hErFjewHjIN/ZBWkV0TZsGwa8i/1E8qzBVKLvVJWMfnReq89CjuroLY+6eRi8CNEP/R+MAD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jdmupUj8dRVHzSvPiD7teRKkuzuQ5+Lw+Vi4J+EGwEmLOuYM0
	rx4KW8pqqweJDQZYxsAFXNlR9sIh78AtFTHSS+Ys7GeAbS4G4Rg1hG9u
X-Gm-Gg: AZFdTZdiH/AOoT9YJQjDlFSMDgVxmfXLeZ6Rk5xO4d6+lFnSnbzsSSrUKVGokXDCI29
	S1Tr7EcDZg5zoCZ2LK/8uy9x6VvCd8L/zrXscLCdUAsV+mbJd8IJu6T1M1NE13nicxwA4gPnETt
	PgtTgt/aVZe2GVqLRhCa5mrBqW44G6zIUQhUZY1Xb14lAdDFx8feroIQop8WD5rbjtLmmJlJCUb
	6a7CpbyJlrfhV+UrYlR/3ZY45uwcOzEDmS/Q5vtrzvp5SXJA3q7TiULMy4KA32+mneD2fEH/lHz
	35vcOep39SYj5n+O38DRqGN82ogUIWyd+wbEC0Ri7SxTKQgrrfAkWdFClQ5d308smWktx4jchXx
	e4yewhNtCa4E+re+iJdA4SjGDJK+QmQaIFNJgYYcIYfjDXh6ewzA8d31/nruaL/gXUXkbiLQ6lh
	R30C0Tz4lpveayUd+fZTLNSEe6wNURQAsb2CtAFaQrvxsXJqNRBa1msLMfc2271ZY0cCq2QtTJq
	ZKoxFHXQON5NpvGyePiyUgeMQSOfMZOyCv3Q5fD6DVDvbIbxvVS557C2rDQy/GqKe49b5ZOReRD
	fYomlrT1Pc9BKYSt0uENDFLl84y0+hv+zkg5SiOYQy8aTCn7duNCkKAIBKpEWhk/sPfhZAmEXbu
	oAiXyxOPyFpWDvApUWKPpXd9epgFP4r96Dg==
X-Received: by 2002:a17:90b:3c06:b0:3b3:c9d1:9b65 with SMTP id 98e67ed59e1d1-3b41c94d32emr15745867a91.51.1795581889481;
        Tue, 24 Nov 2026 20:44:49 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm28659401a91.7.2026.11.24.20.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:44:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:44:48 +0000
Message-Id: <DN40NNXNVB6R.263I8UYD7B329@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Bradley Morgan" <bradley.morgan@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>,
 <rcu@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Add rcu_read_unlock_special() into btf
 id deny list
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
References: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
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

On Tue, Nov 24, 2026 at 08:01 PM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>  BTF_ID(func, __rcu_read_lock)
>  BTF_ID(func, __rcu_read_unlock)
> +BTF_ID(func, rcu_read_unlock_special)

This will break gcc builds with KASAN and WERROR.
It was my suggestion, sorry.
The other entries are global functions. This one is static and has
one caller, so gcc inlines it in KASAN builds.
The splat in commit 684c68d92e2e has no such frame:

  rcu_preempt_deferred_qs_irqrestore+0x74/0xed0
  __rcu_read_unlock+0x290/0x3b0

On x86 __rcu_read_unlock() is 0x2f0 bytes in commit caf3ef7468f7
and 0x120 bytes in your log.
Without a symbol there is no FUNC in BTF, and id_patch() prints:

  WARN: resolve_btfids: unresolved symbol rcu_read_unlock_special

WERROR makes it fatal. Sasha fixed such breaks last month:
https://lore.kernel.org/bpf/20261019211006.2574350-1-sashal@kernel.org/

rcu_unlock_needs_exp_handling() also runs with .s set and no guard.
fentry on an out-of-line copy recurses the same way.
It's normally inlined, so it cannot go into btf_id_deny.
Plain inline is not enough. Song's series drops notrace from it:
https://lore.kernel.org/bpf/20261023011049.1164625-1-song@kernel.org/

Two attributes in tree_plugin.h on top of your patch cover both.
clang builds tree.o with them. I didn't try gcc, the BTF step or a boot.

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21b..5f2f56c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -689,7 +689,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+static __always_inline bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 				      struct rcu_data *rdp,
 				      struct rcu_node *rnp,
 				      bool irqs_were_disabled)
@@ -745,8 +745,10 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
+ *
+ * noinline: btf_id_deny in kernel/bpf/verifier.c needs it in BTF.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static noinline void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;

Pls fold it in and build with gcc and KASAN.

Please cc Paul and rcu folks on a respin.

pw-bot: cr
