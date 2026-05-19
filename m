Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4983A0E93
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219932; cv=none; b=eerVuubtnm6Pkst6NrZ7hUOZX6mXvtfYVZ9TSAroaAeQwAx0ncYUTWUffXRRPZB6ZGO0NDNaVbg+VOAhaZFfda+pV++EGvyLRhPA/B87WrMQjLhSsKRGQiQkPF7KfP66LMdg8CCX5v32+LtzYgMFk2ONtoAF1OuOfDENh4Tj7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219932; c=relaxed/simple;
	bh=qWh56X7aUC/LYuqv1uyB7V3OeBHhVcVqIZiSpCS54nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWNiPaKsjP1TRQa8eNOh2e9IxAht0kuiGeun8q8n7IJzvda7Q3y7T7HHwQUj+FU0YwA/jJpiGr3Qk8meb8HoTrup52d4zHTOXrnaEUtI/f04+BTuiXOWL2nwO92DZ/RAhYaWVHx8UuO/xPWouAUYWUnU3tPAY3fXvlwOz30Ix4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7xamMJU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7xamMJU"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39378db197aso45065081fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219928; x=1779824728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZbd7C6MnBodJyKouu1P8zuBbO7zFZawe+mPjisSXM4=;
        b=G7xamMJUI/6M4wCDlpwfmB1cZzF7FnmF8YuvKv+m1Y1g67YH6/iP67W0Tgk7eLmga9
         z5k9LTAHpNV34g95RwCfdinHPtcs69kVqeIaMiTQeE+PXJdNisMRMXstHM29FvX+G8V7
         6Awsrf2ppHqzuD+CAGmYkj0/WPb+1aSmIBW22lG5W3YajoV9Q+UGW9ndZx/PpUUvQcSf
         XWfX6IFc7hBBpgo7+7chmnXUOn3T5y1fJSQYdm1pmNcM9bFXxMOAP6kU6EySNcUODo37
         Kunt5mhogNkSdKG14z2QU5qX6kRKnPpOXPK/TwG6q0EHMBT6XrmM6BG4FZnV05wjb8T4
         lyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219928; x=1779824728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZbd7C6MnBodJyKouu1P8zuBbO7zFZawe+mPjisSXM4=;
        b=VssEx8XhU6SjTT0ct+GgRfWG56oi2ra/TjsPaq09wbcx+zgsb+fpvlPrDhqCRWt+j1
         R2wVo70jWR7P9cUiS9GuF1d1AlMS+/BJu5wKlaAL2mGAxnXQ85O7eRzjpjm+UZoOA/VT
         oxQih8JWbDGMKnka+0yjfL90RRHiRiIB7ZedsVAa188dhFTXwJtQn584PlcIsiwYt7ss
         sOZiKILFMnMJeEVXcc2MDAn/ikDvxMVBvAqAEsd99Os76/lNNsQT21ETTyeCDvWCeNPp
         W0gF9FkzdylH3lhXF3qFaBlu7wbNFg8Wo69y8U4dPmXB82By0/MU5Y24JJwFwxWzvAer
         cr3A==
X-Gm-Message-State: AOJu0YxiJiQk5UsCQy8IDBkUFiZLv2UN2DXI0kVDjKG9uGo2l/i8p2e0
	SqJgPxXoIaDg2BXucb4Yu2rFBEgPJdbGBjE00NYoe2sp8TYx6t9b+OUS
X-Gm-Gg: Acq92OHfVQcudsJ6t/8//G5sSls9Em0eJ+rGKvGhg3Qfqewsgl/dq8diRhdk3hfOI6x
	JLIF8aimKD4Nmcjw4ZfcIzhZGjxI9nB6FJXxM2CQwZLbWikmqONEGAJCYLRLU4NtZN6Ckvu2fHd
	ao0KwQG6J0ip1HMDhvnXaGIhl7Ue0dab/j54o/ok17KX8L2Sh79saAUcHse2VvpSOffzxfPKw/4
	R29N1iYz8Vy3bBaB+C5jR+i8HJGWAZKD7dSRXMUMwPxG/Rwt0QolOX+xRXPdhXR7VbR9lzXEM9b
	BQ8SM59ewlEsQFSDh6aNnLJyFe5o3qtxPOniYMcnSFyq4MD0qAEkaCzlVXDQoc9YFWyxQHDs8eV
	s9oIOcHqR89K36/TyWX/Z59Z6Qyn84xOYruVPDHmlbfh9+QsyP+O/iiPvmm8O6tBC0VWcj0HaIs
	RlX9UofBeiMGCsxlPamcUVzuZkzQ==
X-Received: by 2002:a05:651c:4203:b0:38e:a181:9e41 with SMTP id 38308e7fff4ca-39561c9484amr56822831fa.12.1779219928177;
        Tue, 19 May 2026 12:45:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:27 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 03/11] torture: Improve kvm-series.sh header comment
Date: Tue, 19 May 2026 21:45:16 +0200
Message-ID: <20260519194524.158515-4-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The constraints on the arguments to kvm-series.sh are easy to forget,
so this commit adds examples in the header comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-series.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
index c4ee5f910931..be9412538fb8 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-series.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -1,12 +1,13 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Usage: kvm-series.sh config-list commit-id-list [ kvm.sh parameters ]
+# Usage: kvm-series.sh config-list commit-id-range [ kvm.sh parameters ]
 #
-# Tests the specified list of unadorned configs ("TREE01 SRCU-P" but not
-# "CFLIST" or "3*TRACE01") and an indication of a set of commits to test,
-# then runs each commit through the specified list of commits using kvm.sh.
-# The runs are grouped into a -series/config/commit directory tree.
+# Tests the specified list of unadorned configs ("TREE01 SRCU-P" but
+# not "CFLIST" or "3*TRACE01") and an indication of a range of commits
+# ("v7.0-rc1..rcu/dev", but not "cd0ce7bab0408 ff74db28df623 17c52d7b31a1f")
+# to test, then runs each commit through the specified list of commits using
+# kvm.sh.  The runs are grouped into a -series/config/commit directory tree.
 # Each run defaults to a duration of one minute.
 #
 # Run in top-level Linux source directory.  Please note that this is in
-- 
2.47.3

