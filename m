Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CA2F3614;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190472; cv=none; b=JmE472zdA05E/q6pxZKCOcHhQG0dtG77mnty1Lkbep+GXoR8BADvtSUo/Pz3xL3Fsbtr2OdK/J7vsT/oC+AKyuC1Tg3327ACdixv7WgJ6mhxi/ai4QmfgCfsEmcIyfPbWeiYhlyl67TZB0fYYL6t5IQ+nz1y4wIPtmady/eDT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190472; c=relaxed/simple;
	bh=JJKodAU25WQC1/F+p/J3EvT5HdwuhzjolMioXz0TpPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQov+2QeJq1XGdCnKuGmtSHQ87k3Xi11Pw96f/s6AuG36xz0EuXZOLwaaB86M6Am4jo9/ksXgbnnVdPIRne+lsAf4Y0CO1vVOTEeWgVOChp24+Hd5PXkxfEHU2PZJtA9eQGuqdtosT9WOlrtM8favpq2tRNo0AX3ZLTZAFtILCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHVRGnpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHVRGnpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579DEC4CEFC;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=JJKodAU25WQC1/F+p/J3EvT5HdwuhzjolMioXz0TpPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHVRGnpPyQDEIpJU7q99ktHi/6yllVybXJXOSLkGp9kw2qtPZrMtkKTbUQIUXbpBc
	 hzw+v3W2NDIWTfKN6SHIG2d7rgtPGRLHDv5kolOh8dzJ3KdK5RpjuHsMtc99Kc8NWI
	 BP9VKmw7IZZ5x+fzxtnkCEHT8XUbr6Vgdfh3kPMH2SjJh8HKaDieJ+gBt2YLPZgjEj
	 Csax6DnJXKRbmdFyPY5W48NvXeO3xcUkvTFySDH+tdZeR/sRGRVO7Ak34tO1MfP9fl
	 RSN9GnGL8zR4C/5miSkp3zBzQEhCHKf8Ewi2ykTbnAIB2G7+VTesxqJBzLHjdbJ6zi
	 aaSLxKpXmBapQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5A18CE10B6; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/8] Documentation: RCU: Reduce toctree depth
Date: Thu, 18 Sep 2025 03:14:27 -0700
Message-Id: <20250918101430.2592294-5-paulmck@kernel.org>
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

From: Bagas Sanjaya <bagasdotme@gmail.com>

toctree index for RCU currently has maximum depth of 3. Since no docs
currently use more than 3 section heading levels, this effectively spills
the entire docs hierarchy.

Tidy up by reducing toctree depth to 2 (only showing docs title and
second-level sections).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 84a79903f6a883..e1be5b3c2c6773 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,7 +7,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 3
+   :maxdepth: 2
 
    checklist
    lockdep
-- 
2.40.1

