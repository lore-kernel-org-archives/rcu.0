Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849992;
	b=wfO5yl908ljHUE4hFPGmnG7lwJj3lsFmtP1MR5MVwVgrNHeKpsILgtFoMpq/bbYQbj56
	 3xLJHETz3Z0hwnsGDZJD43djJgUc3aSqrMrfigpsQ8f+X8AMs632T4nmfVPPCHOCTN+i/
	 ZRo9/uGqgiT6rv3Q6hSsL24vf2odVanzcFCdXnW6kAHYmJOOi201ySUJfgn725ayX5eXm
	 u/UaayN9C4aHBuBC1oaAqpUnUzkXLFKVZ+EvQ9OkOIxYZZaWyUkkjK7duA0eZLiZvs+uZ
	 NmZfQLqX00REV/7alzO7UuecEWCuAH+pZHZcnbKdqySi4+B28hCwGo8Iys5eEXpS2Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849992;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=799pxbWu9pD5xdtludeThN+v10o3r7jfv10yL1+vqnQ=;
	b=tqCLAqoDipVmt3lUZvaUp4D7MXN8ftX5/7DmaubacW85DoQvt7J1HkiWUF+eX9yt8zMe
	 4IgWuOj01VArVs/8qqTO0nuZqCBZuvxNPaUNZvUdYPaoVpft8oY6qHBCwFeF0WO+ExYSC
	 OPNtAg1fMxCwhk00UTn5p19Th2J95dugs7Q54Pgd+jN8CqiQtFhZhwWE01gLyPlw3+4qz
	 AIXNCZjyeilCa5VGO0b1HrzwJkRXkjEEXlCFdTQHQAzsd+aCu6GYMByDu3K/sFxOcHgUE
	 QEvTy35DSVukhmc+tvFrxGaKcOfuHx8J2fvd6PvPTZKVEDjudaD7JaohfQWAAApt7QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxTjhrCB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D9606A333;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxTjhrCB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A7D1F000C9;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=799pxbWu9pD5xdtludeThN+v10o3r7jfv10yL1+vqnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxTjhrCBtwhDFge9fZKYR986ABTPWVDDcHGGKFmvmjk0793/KGHsGHW1x2SLqj48M
	 ToUmWr59SQ4tkxtyEwfo99B8O7OtLiY/UhXTS1WThGYfXO5urpKctuaooUAOXQ6rO7
	 Cc4DVSd5ubi3ugn9PlD5nRk8umK7QewD5tN+Ir6AavfVEmk8vk64rCVgM8+Lm+f5Pv
	 hvVe6dHI01YtZFVt0tY09jO1qF2hOfOOS/xQMqZuzJrQbF5pA7vesZA6/5camYLw31
	 9a6PTQ7F8r6bWIs5kOwqUMpmodbwn70UULP716Tk5071TaE3hVxQ6kmU46PKl8Hs99
	 6f2ovv73EhXgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 453D0CE0A01; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/6] rcutorture: Make torture.sh test NMIs for atomic SRCU on x86
Date: Mon, 16 Nov 2026 09:26:26 -0800
Message-Id: <20261116172630.3845508-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
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

This commit adds '--qemu-args "-cpu host,pmu=on"' and kernel boot
arguments "rcutorture.nmi_readers=1 rcutorture.nmi_calls=1" for
--do-atomic-srcu runs of torture.sh.  This ensures regular testing of
atomic SRCU readers from NMI handlers, at least when running on x86
systems providing PMU support.

[ paulmck: Apply Mathieu Desnoyers feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index ce6b7e9589fe5..cd023272137a0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -523,21 +523,24 @@ fi
 # does not support.
 if test "$do_atomic_srcu" = "yes"
 then
-	torture_bootargs="rcutorture.reader_flavor=0x10"
+	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1 rcutorture.nmi_readers=1"
 	configs_atomic_srcu="SRCU-N SRCU-P"
 	if test "$ifnotaarch64" = yes
 	then
 		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
+		qemu_args="-cpu host,pmu=on"
+	else
+		qemu_args=
 	fi
 	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
-		--configs "$configs_atomic_srcu" --trust-make
+		--configs "$configs_atomic_srcu" ${qemu_args:+--qemu-args "$qemu_args"} --trust-make
 
 	# Half the readers then use srcu_read_lock_atomic_irqsave().
-	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1"
+	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1 rcutorture.nmi_readers=1"
 	torture_set "atomic-srcu-irqsave" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
-		--configs "SRCU-P" --trust-make
+		--configs "SRCU-P" ${qemu_args:+--qemu-args "$qemu_args"} --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
-- 
2.40.1

