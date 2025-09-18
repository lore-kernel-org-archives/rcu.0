Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7022287242;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191394; cv=none; b=u41atmO6ztHMG8x6SPytJN/Tn1+yCgfhkhV/AIXpvpvUVP9gaRhYt26BfMli8IGLxH8txrMbKmrBFX2U0PY1d8syUuyvxKdNFRzywtHE46y1HMLiEQP6ctajnFg3lrU5C9K7+TovbosKc2VJkvSxVi4tBZvLQjFcjJmrSezv6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191394; c=relaxed/simple;
	bh=Cz/f8Ty/4zEpoYFihblKVOHBZS+Lk96uBujFwo+m+CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADl3c0lIwl2dwI6FtRl2LCMGEe2bozkEkJlbjbFQU5Fu1PCnvY75tMmOqA5wMEirq2PhBeH5VhqzORJC0GmDmmTwb8+AtgT7RrTBUPBZxL9dIxvDM/BvjGsTruN+VVZ2tyx0PW/Rrhy4TiRDeLS0sv5xYsrOaLdC/XE6YKfwF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fum2RgkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fum2RgkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7635EC4CEE7;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191394;
	bh=Cz/f8Ty/4zEpoYFihblKVOHBZS+Lk96uBujFwo+m+CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fum2RgkGRWgBJRmwKxED4fccQBDTOLQ4f7p/y8rgEEt0s/GudsVc3YzgsSdc2150z
	 oAvB8oqQgUhalWzlQT0i4/NvTg9p7VyGALURQmQhhoDR7AEjKGoJdtdCLqARu2wLkm
	 /gFedysQgmoqoAhSW7DVIUMwA//rxxKxbWmvqIef3PPxyKoAVbdib7EefdE0kbaVMM
	 gzQ2C2FUwLGQb7eQljO+8smXVgeC09oyXZE4Xd2tvISLy9QYyqw4bGpDvGNzQgrI/N
	 PZVc5GSCjIf/bqakEcvitRNnD+XStbY+xKOJTDB7WAoRh/tUiwM23VLJoB45qX0Pa+
	 a9cf1S+chvUiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D054CCE0D66; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 02/11] torture: Add --do-normal parameter to torture.sh help text
Date: Thu, 18 Sep 2025 03:29:43 -0700
Message-Id: <20250918102952.2593045-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --do-normal parameter was missing from the torture.sh script's help
text, so this commit adds it.  Hopefully better late than never!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 611bc03a8dc705..a33ba109ef0b7f 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -94,6 +94,7 @@ usage () {
 	echo "       --do-kvfree / --do-no-kvfree / --no-kvfree"
 	echo "       --do-locktorture / --do-no-locktorture / --no-locktorture"
 	echo "       --do-none"
+	echo "       --do-normal / --do-no-normal / --no-normal"
 	echo "       --do-rcuscale / --do-no-rcuscale / --no-rcuscale"
 	echo "       --do-rcutasksflavors / --do-no-rcutasksflavors / --no-rcutasksflavors"
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
-- 
2.40.1

