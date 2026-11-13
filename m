Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531027;
	b=0aFR11n+EwM6ZhLzBCGMMSLwMsqbjIFEEcwOc6CgJMITbQ4dXDh7W5IujqFev4fOnFfp
	 Lqk4nxYuvDoGCaxfl8/tVeCnYbeISFi+aAzCn5riaVWZ0MV6/McnHR96ZFLyR89rTvok2
	 j6RqBq3rnETDigLeFjQB16bhcb+iY8wdGTnzvPPSd01CTPoSw9YPpewDYQplvRCWziJNJ
	 LJ5CB8DLKZnUdI+ofImQBfmbS0QvaWUsm5jBhfBfV4cSmEA/AAAklKWKHjKWvaDU7/mvF
	 ivWBX6BMbUCs4EME0GThsBCMfaVL0uqkck/zp72pOsvc2jbOkCZx+ZKrfLUQVwet+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bVS7FfdBd8pmcqa7/Yd2XypJEkh8XCVghodHDCm8VFY=;
	b=EX04j/CCrtbhg7r67VUKrJ12+7gQiOSFTKd0b2r4hRypNvuzgTCo1M+xcaTzG9HE3ngB
	 6tHt48XhUzFaulH2OChSoZy6A9UKQwzDMEcI/4u5x85d5D8ZQ2N/EuEUVbOCEf1E6Q7O0
	 hUKL7CmNzdu27ylRk854Fga+sGByk+OQbyAiWfKU4gN8v3w87sJ5S8PNf8Mw50pdlsg8v
	 bP5zhp9drkfUVlDHYkyCyddQWhW1XR6h/N/ycxDlsiNp+fBaOpZkUfzbS0NIvTjzuQxBx
	 p6lWCzQKi7hDsuNnpvgBgQ8NYNg3TiUmhvDpj0augHCsaAz8oQp3nSxDRzcxvDcuU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd1b8EIr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2C84A60A2633;
	Fri, 13 Nov 2026 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd1b8EIr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B2B501F000C7;
	Fri, 13 Nov 2026 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531027;
	bh=bVS7FfdBd8pmcqa7/Yd2XypJEkh8XCVghodHDCm8VFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zd1b8EIr9G25B2SmPDUSzJPOciA/B5YOyL2P2ekBx5vuSBz33DxsPvSMHqp0u9WHP
	 xkLSVpPwdJWi56bbCB4dcPQd9j34wL8a1VlMEGurKjC2+F5UmWz7BerdTijNa2H6Wk
	 wP8jtmZTaBthDnQiMDMf88/9OVellpI2xJla3SdHEMc9afp8iHYOphQz9xHQRzbXT7
	 MmImNDM1CTik/ActWRll4FtEt4YEg7pcRvaDxbgZaXKaR++sDNxNVVEc/tXRWAmXK5
	 8vaIXQLKk+9u7GIBF+C1RZR1TlLk5+OUAQtUnleqBuJ5J7TXVl5S24XlvKrCqQsyDu
	 tBfR7Ioesxg/g==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 04/11] rcu: Record callback registration stack for Tiny RCU
Date: Thu, 12 Nov 2026 19:50:06 -0500
Message-ID: <20261113005017.2772440-5-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
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

From: Kunwu Chan <kunwu.chan@gmail.com>

Record the callback registration stack in call_rcu()
for KASAN diagnostics involving Tiny RCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 656b6a682e31..bd22fa43108d 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate_wait.h>
@@ -251,6 +252,9 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(head);
+
 	if (should_rcu_defer()) {
 		call_rcu_defer(head, func);
 		return;
-- 
2.54.0

