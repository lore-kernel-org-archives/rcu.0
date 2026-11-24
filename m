Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546631;
	b=oOj2AYrJUe0ffHqqYWnwQk39MVUoSLyznfoSrfb15S/kmb7s9KmVhqE5nM5nms9Yjp2V
	 3p9NaGh8ojgZVBZe4BsvNuluLaCxqiI2Jyod+gGTw4uXT1QYv5Qqm1KT2Ye2/sV1HdUs/
	 MM2ggAngQvmKTr9aADTGk+Fe4YE1ZkBE0IC5FlOvWTxan3j0ZK5Euy+FuoIzD0d8aiLDT
	 khwwGaQhlPU7vfWMt5JPFT9gd7mOKU4ddfh4Ybt9mD2KepQBZhj+U0L7MQ0A2vYR9xcoR
	 WP09yRt1++1YXuNZBrSpzEEEm+2zKkkgpXjJnLlbzuvxfxyro0D86qa0P6WOIqckLuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
	b=k3eSDAF4d/ZCPNhDZmj/VB4oOpR0CoBfVzMpiwx+UxscL+pSSlVn81HYIpkvW7cJfZ4J
	 QvgMPKeRT+xLVhPF/oR5xCEXkNlGJ9d/zb8oHKRLteYwhhIfPtRy3b1DCnwQpaRdjtq5x
	 cqYEzcQ/UxIovPuQ1U/4KGLYA26arVmz3HfpuvwxFVUireKTp42oilNphnr80wUh41Hry
	 h19N1zZ002HdtVfOpiW2thNzO3d7M5DL+1zaa3vdQD0XxbPDSFFRElplW5k+BaK6yX10R
	 WLu/AQJ4XioN3h0pxSUZ3wFovJZkSJKMWrgu9RMkzz1fNw7bGSpgbEgW+Giu7aS1xIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hphrqmhn;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A19606A327
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 18:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A19606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hphrqmhn
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso2439803a91.3
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546629; x=1796151429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
        b=HphrqmhnFR6ceVJnnr/kHMTyQArxBxTQQMxHXWQBXvUpnd0mopwa5nph77tZLWcR+f
         f+aGEN1hVgFAhXGuATZk+HJakseSOSMwnThINi9mMyQim7ddvjAjdlCCfGxxETUdYq21
         ggzb/aG9I/pOBlMvZsMW8pjsuqbB/YGIpij6+c4/E11UGNSZFMK9vbfRW+QySoRQgc+7
         lW4DgB8aDyn6zY4e7hw+17dI8liB5BBLFM/5kdWShHl8JOT9y/ZMPNfJ1riwVEe5RvQe
         f0/hKObHkjQTqspjMa5cBCl9rNp8+RQeln/CdiTz5KaraLdVN9bBhhXScLxo3PEZS7WE
         qvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546629; x=1796151429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
        b=mz+4EcXKD/pNVTE5NbYh3I95EcsApRSn9O6HKmvf9r03EHIt96eV/Q4g22K5xBs3yI
         6ZPzkYcfe/MknqWbmMCDDjJXMdET0wuwxOe6eDJxLY5ZwV7Mf/biwKZ4xz0cYqHe1WXv
         F1LxVEDXAGikaRPoh9DIHkMtIc/DvugP5Xgu2nbtEvUSLdHlwgKnEKDjPMj7TI239/d4
         llpkbDxarfo3hASinPTqxT/9c6inncOs6LHa6yDJl8//Sm74iSuwbKgbiHA6SMawt5sW
         eQ7G0ekQUicVnHeC6NYS5itiPHrTaDqDR2H8/E7ZicI/ynGVSxvjAgqjslgMI38acdpk
         27AA==
X-Forwarded-Encrypted: i=1; AL+hErHhKKfsJSV/0/PBMeLM7TKYhfuFfCrSuDswnuF8YwNbkkskJMHBUKaPJeNZVlCHbXviuZg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qyQ9BrSUhna/qBrvtFLaW5o3pYaQDRhAZHOD6MiIZkgkNjXB+
	kcVdhcTC0i7LmSiOiYtSQlBpBY+1bltHp8w3BLuDzYGu0gM6WqKjWCoM
X-Gm-Gg: AZFdTZd8fzEviOZPBkRdOobQ7o4P4/ozCWE5V545YlThZZ4AzBwE8i3D/EdoYH8GfQB
	fA3EgI1om/e4AVkSf5jG7r39P3uc6l8rX0IvmpeaHiL/oeaxmQRqxQo6LO2XPn/sYB5NJRSOZnH
	XeynPWZuW+TkFjunoV+YDWQktNmwfKFiaBptCZWcYJk1pjZi06UPZozalw/ySDq2YD0cNNoyX+N
	qSHav6qjZ/S85WI/pDSBlfMHaDIEITUpw6eKs8Fz0xEydCBMLu4X8qhdMiXImd93O7tq7t0blet
	iDwSZDwcSP7oXw9uTzOCAlzowGFFhMI4jHfmVX5ArQ9YKjEcnTJ9HwCM2XQ43TLqjRAig7eIU88
	JZdoVCVkHu7Y/J3K15XLuWGztdeYTczOtufaY3R7dUx3W7kEL7XHaw/efS6lIM08kd9CBQrSU1r
	t+hRE6eItfVIjnsrFZudUCKBkc6CjMfG7+bylcCYgKjuta3MpYFBCOKNuVcoQghOCqdwdKnomlY
	+huIxXO2jNbrm3tOw4mW7kfMzS2Mo7DOo5WjP/R2UFV5zpJ26KI1iiZlkJeDhvbOchcoVH84k0L
	jej2sp8CkLvw6RVKjjRq3aD6s9gXug9msOR0PHOj5eRS/N6SMY+gFMM/yzaUOW/z
X-Received: by 2002:a17:90a:d2cf:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b41c7c22b4mr13144995a91.3.1795546629335;
        Tue, 24 Nov 2026 10:57:09 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm26499487a91.14.2026.11.24.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:57:08 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
Date: Tue, 24 Nov 2026 18:56:51 +0000
Message-ID: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
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

The BPF trampoline calls rcu_read_unlock() on its exit path. If the
task was preempted in the RCU read-side critical section, this ends up
in rcu_read_unlock_special(). When a BPF fentry or fexit program is
attached to rcu_read_unlock_special() itself, the trampoline runs again
before ->rcu_read_unlock_special is cleared, calls rcu_read_unlock()
again, and recurses until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

Mark rcu_read_unlock_special() notrace.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..a887ab69f486 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static notrace void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;
-- 
2.56.1

