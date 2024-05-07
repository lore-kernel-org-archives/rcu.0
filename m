Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA715E5AE;
	Tue,  7 May 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074556; cv=none; b=hXlHrj9B9cYyUlihqAxjBYri4uNT5kof1i2bUHMyXX9WUTCAfKjAnbK2KhNy00ezgdzwsG/BERwmHABzov+rnCayWDxTnX5u8jyW9cDgWdFnQfn4IpoL3MgHQ/+4s8cU8m455yQ1+3Nyv1p3L8x+ShR/WjJHfL5/i5lT/X1xquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074556; c=relaxed/simple;
	bh=1h5PTnEjN3XTAEqeqf7c//E2/U6L7mwbdJGy/pN+PlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8Tbde0AFir726XfPtjEUnwTlQ/Fhw0qf8zj7zUM5PdPTv77z+dJ0NlZXesZgxtgIt0vR8t4viTOjEtSbkpytBZGKXNf4OWE/v9QmA4Gf7sLUVFUuWXLvHYyxC0orSj7e66F2T2nVUoL4SoPjcmRroGpwYbg+/BuxCuyJM94sJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOE9b1mN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOE9b1mN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso38860561fa.2;
        Tue, 07 May 2024 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074552; x=1715679352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp3uSRTGzyTrrsXKNuVnjxaJ4vNThArGqCT0EkGmYcg=;
        b=EOE9b1mN729TAe548gtngGm6HviMcXY8bpaGi8vjIrTO9ETLmsDDAK0INMuNC7RtJA
         GGfcJaiH5VKQjYl4m0c2W1RNsBDsA3kMh1u01XTGPfm2OxfM54Zm45GCaFzYtODF3tyX
         bhETmzRc+hmNN37e6xB9g++MGHnidTQdB2GNdMReVZwI/AwBabI6v5CSsalu3nKb/KjL
         suZG9gkbw8Yl1br5/LPIm7wD888/7dmb0iq8etXv+VopnEF4HHCSuqPPyODjvqRErTUH
         N4/gfE7EBT5UE7BgLa1Ax7MHBu8NWEGC+2U3quHZGOYzdSrm0hwb2i/CUE3uxaohQBbY
         Fi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074552; x=1715679352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp3uSRTGzyTrrsXKNuVnjxaJ4vNThArGqCT0EkGmYcg=;
        b=AWzs0qVSaYei5Ca5Jj39uEG+d6L1Ze86A6fAw2Tw+lGJcHBE8zfUN5MPhzNj/rt3qj
         0EPeebyTfWNRgnsnJCJBR6C+YZN8O8Uj6t/MW/wjiQ41Qpvz7XtZbP3pur3X8vV+aRVR
         zcGkX12NTnhWMUq+ZRsz9hIpaQD32WXieRYTbLpnElQPuYh9/aga2kYTud6jVIodqlUL
         kOo1gDa69aj925f9rEwFSIIu9CxgseFr1o4PoLAb0w+6BhV66S7eMbojsRsVSckUjlvg
         uFdTFa5L1vAP5whmUHHMnZIrnU9bGcY/6LYTzUovhPt+tfu3yRlfbEBgNEzYrf9YIbCJ
         sMtA==
X-Forwarded-Encrypted: i=1; AJvYcCVN194zQzSqj9eLv62CPiJ2ICQ1vYHOaT+WfHW/IKpeNl5qE4sMmmjDU6CP9VNvtwYLbeKteEy8KP0UtfHCpIPy6o2NYkoPBJvFDY3i
X-Gm-Message-State: AOJu0YyBW1vNPyUTAH0fRvQMuznwXRt5/Ry8V8jRvj5lATHCijZnKlve
	Ep/ZPmIg1SJ17s+/yxtQ4ec0+rJ787+FIWyrsJUhEUB2bMsTWM0Z
X-Google-Smtp-Source: AGHT+IE97GB1z3q/6z5Vg5BApF0/HQT/0T3sW/RXQGwdM0BmQEs65+Yo/TSCby+tMP48EVe8SiCQ0A==
X-Received: by 2002:a2e:be8e:0:b0:2dd:cb34:ddbc with SMTP id a14-20020a2ebe8e000000b002ddcb34ddbcmr12375237ljr.48.1715074552165;
        Tue, 07 May 2024 02:35:52 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 20/48] rcu: Create NEED_TASKS_RCU to factor out enablement logic
Date: Tue,  7 May 2024 11:35:02 +0200
Message-Id: <20240507093530.3043-21-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
This commit therefore creates a new NEED_TASKS_RCU Kconfig option so
that the default value of TASKS_RCU can depend on a combination of this
new option and any needed enablement logic, so that this logic is in
one place.

While in the area, also anticipate a likely future change by adding
PREEMPT_AUTO to that logic.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7dca0138260c..3e079de0f5b4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -85,9 +85,13 @@ config FORCE_TASKS_RCU
 	  idle, and user-mode execution as quiescent states.  Not for
 	  manual selection in most cases.
 
-config TASKS_RCU
+config NEED_TASKS_RCU
 	bool
 	default n
+
+config TASKS_RCU
+	bool
+	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
-- 
2.39.2

