Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016282FB619;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190473; cv=none; b=kn05dD2tBLobZAcBrQ3+KSS/Gi6/S3qtCbQPAMpVO1A43PqN/wTSqnZoFvVPM/kH0Pay+blxv2vuae1L8JJxFfPQmBwCbaMqgyu2rnd0OQ7i47xK2kaxGn/BoEmZ6vEAxsj0HDYF7C0yCHlqMgDXENdk9/HrzWaDVOtIWs5gm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190473; c=relaxed/simple;
	bh=6+lKnoQa9CPduFGKueDA6a0HSk/vSDNysh6fVugQaNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJHrETuGNOf62tnjPo0A9qqgi6kZLjcPaRBV+SFOz9DKSFGYKkG+xgvffPqmzZR/45//gQ1l6ea7x6rJX0iiun0YICozDSVrtkvNF/CuyRuzET6G2RdbSuXaONXtEMPQzCIzbZYRsh7iKSTnJwdtSKJN5qm0lemYAqEOG+A05TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqg8Ffwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqg8Ffwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE72C4CEE7;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=6+lKnoQa9CPduFGKueDA6a0HSk/vSDNysh6fVugQaNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fqg8Ffwhndg+JVSF/CstjQxNRpN0sJwzEov9uEm2+xWC+s+Ad3mMX5J4tLN2HDtpm
	 R9Iw/FMP9A8FotPRBl9qAJ/t2xHpMKKu/kM6tkdAm4KGpXnXzvEEyotoo7UwhvOvKU
	 kbwFkjuHLdRkxtPM7q9xSLONfFn8LFcuKpqb2WuL5P+6AheSjZaegvGHetYIw6N3RS
	 0DNPOtQSOo5ywcmTwTAMBrVoYK5ZHCal4gE7jp/m5rbLH9qgZTp9WBzp/X8G6WwJF0
	 wL5cyxhD2HcKVA31XLAu96rY8c2lnd907U/Vxx0rDGPV7ce43MPE/6pB8dm1ZiDgfz
	 hXk9AS9wrL6tA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA73BCE10F9; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 7/8] doc: Fix typo in RCU's torture.rst documentation
Date: Thu, 18 Sep 2025 03:14:29 -0700
Message-Id: <20250918101430.2592294-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
References: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/you//

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/torture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index cc57d01ed700ff..1ad5cc7938113a 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -344,7 +344,7 @@ painstaking and error-prone.
 
 And this is why the kvm-remote.sh script exists.
 
-If you the following command works::
+If the following command works::
 
 	ssh system0 date
 
-- 
2.40.1

