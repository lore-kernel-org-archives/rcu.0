Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE800453486
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522096; cv=none; b=EM3qaCZZMY/Zd66hEj/p5+E6oKbXw0Jn7gNZb2/BoqGAv1o+UKh07x5DZGvGwbubJN59upHxsmDQBQo22OP7stTVj0lHaJjGfDgnsRiRpCz4qT8b69MnlPq/7qIlix5Suv05vpcL4DFTls/DUGmmXAIlDGM2c08tVa1EGOtMzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522096; c=relaxed/simple;
	bh=qWh56X7aUC/LYuqv1uyB7V3OeBHhVcVqIZiSpCS54nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VofqIj/PAn2bim0zYlcK6kHE55qIVJs823lAgBLMmDSSm5BQEShTYla37FXphf7CRk/eODEG00tOiDay6M/lKEzaMmVtEp10pgpywQH6iDUStQzBOxsh2uW7ZHMuvKoT8apNz0iKZJVjyjWJz7PXsC5aMYVMBbmoDznamyCkBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E23WqaRY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23WqaRY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so38979201fa.1
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522093; x=1779126893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZbd7C6MnBodJyKouu1P8zuBbO7zFZawe+mPjisSXM4=;
        b=E23WqaRYAXWyttPEmASV8IhkW0PcJDDVbMjNXj7Goiacog7myNZfKXDjjjizWbqu6f
         /jhOG5DhX5jp/cWmC1j2pFhpxHy9xIixJGZDx7XqPMgAhdyB+O1JOM9OcmfN1F0VBsBs
         CchgPxvK0abGMzL1EQ8Gv496ctpuA4Oj1v9SsVusxaUN/cfihgz0mtI9WR6SvGkQqmHB
         y5PAitNRGgLqhsorkYPwA1yuxbXRHje4UmBDONh7MztztBSH/nsfnHWcyV9sf6ccthDO
         kJ3uRwvnHUnxhl+8JLrzY1KbnU6r3L9jBTgUcQrRyCDHAhsOH6eWUoVNFi5Z7ZLEY32V
         nnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522093; x=1779126893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZbd7C6MnBodJyKouu1P8zuBbO7zFZawe+mPjisSXM4=;
        b=VgrvyhMGmxunTXFn+DN4fOtd+5EfiA1KfeI1vsvZwWWPnuZtaxTvLWI/XKTLg9pu66
         p0na4qhm1DNE5xeENyTh+Hqyyvow/7ngPVhbL9O9FFtTJZN0kDtxDSQ77w9BOcN6hsPr
         BrKp1N208CrDp9rYuUPzBZy9WbLpEVdebTrYYQIPbObvms9d85FZHJzhbLhcBqg4qEsG
         VYC4nvkjW2EdsnRv6B7lfIgo1UiKvaPylh1J+G0fwDU0yPoGD8icI0Uu4TnGJYZwN07a
         D0FwI4/hPXg1qgBZVVnEmvAMfnjyWzb3VV7z25HTkFdyhYSAypT9dVcu+IA7oiSnF1Av
         xscA==
X-Gm-Message-State: AOJu0YxGO6DyjxAoqpM/bsqKGvZwbpdlhxNIeYPkjEKCrViCmyur4jzl
	vCDsNy717YQKNAs9giTpe0MHuWNoGnpnzS5nIix9+vW8CSpBgGNjr66oM51OrA==
X-Gm-Gg: Acq92OEOpgUUTB5vCJL7CQrGSjv3ncpKuRCkRNNnAbloeMGfqDf3rYUq60st6yyEKws
	Lo72ZCFm8vIb1hyJ/KLnlYTXPXXZnFNB/6iwuxvihzFtmB0u3nOczvKni9kD8SF+YumN5pG4Gl3
	BM76x/kIv1LLvzBBz7FZQHfsvmZosB6bxtpXXqWzL5b1sYrXC5NT0Fs9x7SgWLjYtQEdZhPsWY1
	332kXeCUV5zP0e5TIphdc77IPiTQcxma0lMz+X2L5jZ0i9r36ou1mH6ckZW3+xKl0Vxq8lSZ0HZ
	RZ0k6Q0dMHbcHWyQfTiPNd+xuF6FvkTlFZssOsY8WEf/hGkRsCIbmKoIIl7RESavRxxFvgtOGPw
	xhKB81QAWjRKeHe0bU61prTqnIsgOH0UPYj6MULdPOA1R7Wj0FRuOTptx2rMV0ltjrlffvoCLnB
	AYBFEdwYFRMpQT83yTVNtb2X+5Lg==
X-Received: by 2002:a05:651c:4413:10b0:38e:8902:7a7f with SMTP id 38308e7fff4ca-39408064df2mr23396941fa.13.1778522092679;
        Mon, 11 May 2026 10:54:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 03/12] torture: Improve kvm-series.sh header comment
Date: Mon, 11 May 2026 19:54:39 +0200
Message-ID: <20260511175448.153326-4-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
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

