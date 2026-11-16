Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849993;
	b=VKOlqK/8L37sP7m6OWmmB7wmfzRDCq+fmP4nyrBdXQMP84R72qjgTJsiQg38EP2bxYXu
	 OtYlmG1tca9alRYV/UZteTCMa4VqS+H094tl7RKodL5hC29JTJRSdNfHxQ4FXtIbA8VdL
	 ii55zoIh+s6ndWPUTBZ8s7e9DqKHNUrDjMtFDdij2WAj4e2/nNUCL4iIN/8SRFLMl5TzD
	 hmRnTLND6s8qYWZshTKFaDsIyfiMrV018n1egzrzgGlVwSy8g/IMjznOQXffVkWqyru6Y
	 Uo7H3s5TwH6dqTdMdXz81dCKV2+tBkz021aECHrC6pd25q0wk1AxZiI04E6usY3LrzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849993;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qBwEFnQEcVdAKwkWIQ7HQnR6gf0Ou49tC97b1GBRmpk=;
	b=nQ2jt2MIxz4agA8y9f+Fg8bPcmZU8/VBTfkTteGgJjRyZxjLuBv5yJ5gsZexYksDgQkP
	 MAianU+vlN+hl5lrVAjtp/w4visZnwRltuVUf1Ox2qzSlVX+xzS/q4hqSKc2/rFiP+gpn
	 veGuufbPby9V1Ij6Wa3cut/MJiF2C4vCrMdCvojLqiNwZ33UuGJIEciEIsoETcrm2NHsf
	 yf82svr45przc9IXgJYUz1NmSFUbVUsV3Eue4jfDDI0b5YvA4QBqk4Z3c6l7CGO/D3vfg
	 M9nReOtFD7n1z4h8f1BAX9aCUWNNI/hHVxDvZZjFSizgWo01Q4EEFv5jOZayYIS2oBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oRfbr52/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8B606A33F;
	Mon, 16 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRfbr52/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A51F000D4;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=qBwEFnQEcVdAKwkWIQ7HQnR6gf0Ou49tC97b1GBRmpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRfbr52/omWYeJAiebZOwovPaod4yhPr43I6Aly0vYBpbu4FFP2ONDFVAbze9VUXW
	 QKm+IA20kxQvAxCLhFFvedxsfRx+eZRfAN5oxpPTZrQSz/oVJyNvC8vDjM9du0jQTN
	 F0GzUj4Jn7gViaDIiiLGPTrPQa/m260Eo7XdfozJ4YoHtxYEytpO0mjNOeFsaSDzxj
	 Kt9+z0GIzFcniq3/NhDiwSrYmN8IfPRhUS+wub1dWgNT86orOWUU/sH+6J902OHbNQ
	 F8CDtt0LlcL6y1ZPvEu4WXhfla9Ca2wZc0LjiE4dOpeLU4k7KRjLCrD6xxA4bjL8RO
	 13jPTQE8/5xYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5018BCE1207; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 6/6] torture: Use ${:+} to save a few lines in torture.sh's torture_one()
Date: Mon, 16 Nov 2026 09:26:30 -0800
Message-Id: <20261116172630.3845508-6-paulmck@kernel.org>
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

This commit uses the ${:+} bash substitution pattern in the torture_one()
function in torture.sh to save a few lines of code.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index bc842c94c4379..0498fce14ccd6 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -354,16 +354,8 @@ touch $T/successes
 # Note that quoting is problematic.  So on the command line, pass multiple
 # values with multiple kvm.sh argument instances.
 function torture_one {
-	local cur_bootargs=
-	local boottag=
-
 	echo " --- $curflavor:" Start `date` | tee -a $T/log
-	if test -n "$torture_bootargs"
-	then
-		boottag="--bootargs"
-		cur_bootargs="$torture_bootargs"
-	fi
-	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	"$@" ${torture_bootargs:+--bootargs "$torture_bootargs"} --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
 	if test -z "$resdir"
-- 
2.40.1

