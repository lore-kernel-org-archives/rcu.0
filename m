Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0734B402
	for <rcu@vger.kernel.org>; Thu, 20 Nov 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651004; cv=none; b=GqK4foxgrvnKhegIERW2lFmhzHyKHxuPKK8l1N2HfOqOLdr+4IVB10FIFz9o5C+YC/5xb/xRvHL+kffMNk/etTau+CelmewVWIwAnp31clesP7KNgwT618g/75fHBdP2AINqBJYFQTE5w2z7oJU0n0EgsU9xJaDlbGklpxfGfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651004; c=relaxed/simple;
	bh=tTGjUHrfXR5isY+lSEFNNwASkyVwRARVzePML9vCCTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpnsbaO/LxZBeMt622ZghN2QINrlDv2atJ1O0w2nOn4H+lUo4J7+mg4/aHZ887FOg99B87pkoAMfC57pinEasg54adFSXCk9aTYkj8bZmXglIxWnLn4YLGrWanqnV1yrcu9mu+/d3Om11BBvb31Lnbo7/igys9fb48FBcVGlA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRDQkdoJ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRDQkdoJ"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64091bef2ecso1298449a12.3
        for <rcu@vger.kernel.org>; Thu, 20 Nov 2025 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650979; x=1764255779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTNBohfvQLfYyJiWHtGyLx9FZqAAISthRH9eXaAWBIw=;
        b=pRDQkdoJOB8BfljkDcQrj/uje2IXL2T/x5eZ/wk8Uc4x/XefY5p5EFYXDGT51MXa7A
         I9l55vHaC9zE4/cxhD6UmVf6gV7TpKWoE8cGMDsCdDbQnDkewx6hrqthpt4o94TtQL/u
         MjbcVlir4o3Ji4GPc4Epv0fpq/JlTGllQX22aOwxrTB0zUpmz3DAEXUZAceGwEEaBHb5
         lvxujEoCa4QrSLs6V+CUcQRu2XDzktl3P9vyuulCEbS3jrwzJgkkFTVq1OoRAkt1J6aW
         ekIDBh2nsF6UpK2cJB/ae6naY0w2EbbMIvM2xruXokam9a5643ErVpY8TmJS9Kj3i8CB
         WEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650979; x=1764255779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTNBohfvQLfYyJiWHtGyLx9FZqAAISthRH9eXaAWBIw=;
        b=iqSGOv/jy2qzZca1FMeqFA7V/z6wmGV01rVlCEKSZNORaAr07I7f+n/yjZTEiukJcQ
         JEQTTJmgyTXs5PPBkCUY+Z8rIbEWISiuRNVTMqUfB4HeF+Iq1HySxl20DDMasaloV6qp
         km3BtB18MJ/WpWGbJumkYk1knNuW0v1TW6E3VdLjNFghke7t9Tu+A5t0q+6p/tLNryWm
         lE9IxcShWhGavgpUQ5XWGHtjP/Tt5rphnrjlZti2FFCLIaFXiDmecJeFawdJJu4CRhOy
         LSnRV4Fc3b+Wy62F2rii+SGPPFmB5w9NA9wB/EzbVp3nkNEPtwmaahB4O46KnKRNwfcA
         U8hw==
X-Forwarded-Encrypted: i=1; AJvYcCUiOc+d2zndPYW8y+uI7g1vrVl8ET1vrgJhoySlh3QMSQuw839H2NfnGHunTymUf1JTW4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XziTDZGBisiCYLccTml9O34AgdMIcoT6EclyID75cgqZE2t/
	0RAdL4MZC+vkJ1wiNur1g4IefBAmpI+f6eFAKTGOgZKKGFNLNC3SFq7wwQR+II0BmNHrxzmqIgc
	JYw==
X-Google-Smtp-Source: AGHT+IF9OaX/QGeSo05eKeUEdCvjlZVpqfgwLf4/MHL/rv8J5uT/4osVo9PFxwafA3Q6L9NfftMIvUQ5OA==
X-Received: from edb10.prod.google.com ([2002:a05:6402:238a:b0:643:5f58:caa7])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:268d:b0:640:b1cf:f800
 with SMTP id 4fb4d7f45d1cf-6453d084770mr1885049a12.4.1763650978915; Thu, 20
 Nov 2025 07:02:58 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:07 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-7-elver@google.com>
Subject: [PATCH v4 05/35] checkpatch: Warn about context_unsafe() without comment
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warn about applications of context_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.
* Avoid nested if.
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..a5db6b583b88 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6722,6 +6722,13 @@ sub process {
 			}
 		}
 
+# check for context_unsafe without a comment.
+		if ($line =~ /\bcontext_unsafe\b/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			WARN("CONTEXT_UNSAFE",
+			     "context_unsafe without comment\n" . $herecurr);
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.52.0.rc1.455.g30608eb744-goog

