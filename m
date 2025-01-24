Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694651D514C
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683928; cv=none; b=GVZPysjFKroJDsCtrzrw6RZt/JK+awI6QyOnPcEzGkGpQPhADzlZf4rPamEda3G5q4eulSKkghpfUuUnh3s5h6Cfbq9jimr4pWWYq59fUfjV1QEx5PGJc0dSggwd8/qEXdhc9InMCRghsGY1oJ2BQp9jsUlrmCAzZO6ClqMVHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683928; c=relaxed/simple;
	bh=mlls54bce+0lvfNSi96vEZ6jU4CJvOJNuNga3KxcE+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xezieit4w/A/C9S4wzU7oQyXcCsTn7v2VJ8O0fTVpIECJ382TLull4hke64LLU2mCl4LdZJkCUxzQZqEvP2tXdaxFRXS3Z+T1HTDP5j4xc5EgoSOiOq3sHdfhTeBFHhFih2bztY6II3yQ9xYSIOHAcRW+cqiosNLFTJQllcmlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YOwDyFgU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YOwDyFgU"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6ef047e9bso154110285a.1
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 17:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683926; x=1738288726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaQdwk1K6JMmpEpTCCMueooCLhtDXZocXZ+0dVMaVq8=;
        b=YOwDyFgUkwUyUl7OAe8ejSuXAMFVvQ5NSXSJN0jOvTDHjVmxxX0cISRJMYJRgOOjiJ
         G5k/PxzFQtJkkzvU8Yb6AROkcowPdlHMq8AlmUmHWwZFjhW1YcR6NDyoV1Zre5+KLaQz
         j70Z0HQzByW3gGiy+XB6L4TwopPb+X0VDBBRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683926; x=1738288726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaQdwk1K6JMmpEpTCCMueooCLhtDXZocXZ+0dVMaVq8=;
        b=LakFJPGGrHVNzS5YsHfTwicR2czCV/jenVh9L6Kk1/Dl+9xP0V4LalFtVHCr71T2/O
         dgc58AluIM04rRLIAYdpF68rrwe6s0F6JI/KSIgHyaLxnwc9P/Rm+lug2jPtzRyVjATD
         8VmnlPl+fiMkpiLUT8oKedQ48S0m7A1y1n8I/9zh+MNvVS+jfwCwPquicNu8R0u079L4
         aaRCgr9HCxaSzVwbirtHbubl+uHzomHcefnvDCVkHmxMUt/b97PA6LpGIB7RyJBVDC3x
         26k+6Dm7d2NRijCVmEMWShk7hCJuWZxCReiyxOHwCXJFAKLXsCUTF/LretROdSz4SORu
         VPbg==
X-Forwarded-Encrypted: i=1; AJvYcCWSEi37AKPWiFpZn6UhfXsmwVOb2VxcWHS9wKsA45XEw5/UnrElTiT272Stl0UQHwHwqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPLOl18TA4+AwkK7T4JHWHV5EgPIfaxbNVxq8MHyX6ltJkeFP
	gBQl4WsmX5Auqmp8TRe+vnCMEemFOaGy0xmzpqiOlaBMM03iJ0Ypt0YacDrWdTs=
X-Gm-Gg: ASbGnctd8EHwqIdlQavuH/TvJMaNKDfbbLo03HIzd3go66gxlEx6Iss5cBeSWnszbzo
	4gWL+9r5Sk81cxv71tkTqjC76tpy9PdzVopabetxdX7ui4jA57j911BO9P0w7ba1+Gw9VCRJ3QF
	2z/5x/2U9K9Bv+O3Zed1inMzXZZ2FnhEVIT5/tQwvxtynoo4ty1Lx9SJvPpLCTunmnS09cOVrde
	twcDq5q/kiSO4cZptjIWMqQtYvlp0LZWnjIQizDIMk1e1wYrLw2LwKCvcDL4ZRqb1bZsgg8FPYx
	KTuemVibLEK3j6/hxQFJnXUQ8O0IOn6w3Ms5f81LrymnE6U=
X-Google-Smtp-Source: AGHT+IGedeLyH46JZ6ICjRhHLoRnczUEGAXR32xcGpowOpwEm6uqWspuRRdZr/IOKsIKbb8aqDrT3A==
X-Received: by 2002:a05:620a:278e:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7be9af69755mr301087285a.20.1737683926278;
        Thu, 23 Jan 2025 17:58:46 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:45 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 1/5] rcutorture: kvm: Simplify invocation of mkinitrd.sh
Date: Thu, 23 Jan 2025 20:58:32 -0500
Message-Id: <20250124015836.732086-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else block is unnecessary and we can simply clarify the if condition
to remove the else clause. It is more readable.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 42e5e8597a1a..4766c3023fed 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -275,10 +275,7 @@ do
 	shift
 done
 
-if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
-then
-	:
-else
+if test -z "$dryrun" && test -n "$TORTURE_INITRD" && !tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 	echo No initrd and unable to create one, aborting test >&2
 	exit 1
 fi
-- 
2.34.1

