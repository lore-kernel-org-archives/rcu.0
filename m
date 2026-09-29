Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96254443C29
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701753; cv=none; b=n9tHwPPey4mZPzoIG1kr5HdLRHORWrdMnqc0RVMd69ssKPvfYTbS6CU8xxFD2GYBxgG/R2zlItOSUfcuilL3+kXMxT7HvqcUoAM4FKsrPWz4A5FL6yRuACgaJVnNCAwT8gbn8SB2ZINA+4u+gR396DgnMuOG+v2V7k2coRZRwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701753; c=relaxed/simple;
	bh=y1u2xRxOth8hjZX7WrDCv5jvFeXG8f2oIpSNUGi916M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsMzF7AA7NOgliv5H3nZZF1JtMDmtvpqTgBoH5wzCVTqZ5oe8foheDi1zrx1I80nOY2pGmB3ok7fEqji04c8yQw4q3zozpadDMTkOhpjSarqmx0mVNCk1DpnyDbavAUidNrBhWfsufeKQ9V63VUNA6zOsY9tKWQsRWkOyyeJ1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Oo96lMmq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Oo96lMmq"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd7so356214685a.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701750; x=1791306550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10AkfjFtGJtRfJ5s0PO0ROrjcvpMjCKxs/Q3/9Rbmqw=;
        b=Oo96lMmqSRBIvkhK36ZgDy6m/i873YfFs0xdj4XsBiSf/hCbFmgHfdVPQx5em0TBSJ
         t7PL+bP56PEy3Q5ZY1nO3jAJkR8DR9L5xn4+0ytHwCCI5cFCG52c6FqEZxrnzjNRDDd3
         okQilHYfgcT/wUNifuZe5XSsjF7YrhoqMCN7xjY2Lz5pN3evhUdcTI/FlnLXwxO+yVhH
         fT+A2G/SAuGZ27RGaASDmIuYSKGXlDOVBavgVbt9xG7I+nu+YicD5FUajHZjzHnpQhkr
         325Af2fvMxSHy0iOXgynoZwveHfIUA+9KbnubQku5T9ws4wILo8V0wj65GdztRo37Fak
         z+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701750; x=1791306550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10AkfjFtGJtRfJ5s0PO0ROrjcvpMjCKxs/Q3/9Rbmqw=;
        b=NCX7BN46ps6sOSPBe02yrfzu5uG/P0ySclcEmXMLKZixbZm7LZEl6UJetlDexvWh0E
         DAAAugQVq8onDlf9B97mL/PZ8CgYw/ZKwUHn7hbTcK698jN3BeHVKGiMlInr6TIw1kCW
         jjgPfGPKpFI2gvqPObPX2e+p3F4rorYCSQnfbg4M562yVOy7u2K6jS3M4wfO6b7epVAv
         CCJHBhGgzKtTLotxgG76n4MbUnKO0k5l4pY/rHUAehjjstZA8CQvFbd7nyAOh0x378BO
         zsOg/1XRetOJEbi0PJ0EC1aVM05HtHE2KBbeWIk+OIOy2eNxbdB+CHBqRf2Ukm3lBNMg
         V13w==
X-Forwarded-Encrypted: i=1; AKwUvBwXGxjhWCAcAze5quFGJ1WCtOLf3famwAs+UwIle30mjENnmgQxQyXB/EKClBahr4f466Y=@vger.kernel.org
X-Gm-Message-State: AFuF++ly6zI2KrIo9gG0JZ2xqMpf/DP3mIXeb3FwpcdGVvIqqzxeqp9j
	CrpG274+BDnOaXgDdqaIXXT6eqoHDBO0X/5Eu3IZ1KyycqXmWylT1oPjTFNQJcW6wSg=
X-Gm-Gg: AYBFou3HtfXoBvkDVBQkjWh1511yfCnZMBia+jeWa+wKUydBPZTbhFOSAw4ngKIuysA
	ipTx1eRzH/FVXV9//XqTwCVhQefwhT1PNVhVCIMwVOU+yokEgqmFXPA2lwgw9pfWk4kZKJxUZvH
	1v/9YbVmBI34+BiYPBXm7PoKRYzUjgyenCx3y9OKLQRd48yerMQMFLigaiVN5QwaM3wNV9nDKCj
	f6Dfsv3AjJA+53eFqO9meyoQhxrGLbRijDjaTAl+gfkG6KIueYf0hEW48gsV7/mUjTD2K/JkzLN
	6tfCPsDW5UWkb7tNO/rqVGr0JGnfq6aY1vYjIdG/yhsUXQXoRpoGGAd2yTGsy4wQQ3nY9yK7noX
	k59kzLJEwA0yxJta+OYdq/wHp49NLw+TIl7Du7C7dTefVzlIBd0pJtDbL6jH90L39YVLxg9pDmd
	gaVP5MjWvwEQHUtbIVxpYsgbMbV60VxMtLaQMLi41iRYShvNucvQttg6TdvUFtNgO1TXOqVYBs9
	Epq0dekaekZrOeRvTo0EV5nBA==
X-Received: by 2002:a05:620a:688d:b0:93c:771e:b672 with SMTP id af79cd13be357-93c9f9976demr30255585a.54.1790701750321;
        Tue, 29 Sep 2026 10:09:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f546693sm15090785a.40.2026.09.29.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:09:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:18 +0000
Subject: [PATCH v6 01/14] rcu-tasks-trace: Let TASKS_TRACE_RCU_NO_MB
 default on without RCU_EXPERT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-1-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=1628;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=y1u2xRxOth8hjZX7WrDCv5jvFeXG8f2oIpSNUGi916M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLjB1n/ZEukW4eoCSq390Xy4zsK+XCVJ6PlHFVN7oC6nXmdURQGOs8r7RRxAT7C/fG4vCy5xkt1
 w73J5aAOT2gk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

TASKS_TRACE_RCU_NO_MB defaults to ARCH_WANTS_NO_INSTR, on the grounds
(see 1a72f4bb6f3e) that architectures with noinstr entry code only ever
run tracing where RCU is watching and so can dispense with the read-side
smp_mb() in rcu_read_lock_trace() and friends.  But the option also
depends on RCU_EXPERT, and a Kconfig default is not applied to a symbol
whose dependencies are unmet, so on an ordinary RCU_EXPERT=n build of
such an architecture the option is simply absent and every Tasks Trace
reader pays for two full barriers that the architecture does not need.

Keep the prompt behind RCU_EXPERT, so that overriding the default in
either direction remains an expert decision, but let the default itself
apply unconditionally.  On x86-64 and arm64 defconfig this turns the
barriers off, as intended; architectures without ARCH_WANTS_NO_INSTR
are unchanged.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 332df7a7a634..e3cfe1fe5592 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -142,8 +142,8 @@ config TASKS_TRACE_RCU
 	default n
 
 config TASKS_TRACE_RCU_NO_MB
-	bool "Override RCU Tasks Trace inclusion of read-side memory barriers"
-	depends on RCU_EXPERT && TASKS_TRACE_RCU
+	bool "Override RCU Tasks Trace inclusion of read-side memory barriers" if RCU_EXPERT
+	depends on TASKS_TRACE_RCU
 	default ARCH_WANTS_NO_INSTR
 	help
 	  This option prevents the use of read-side memory barriers in

-- 
2.55.0

