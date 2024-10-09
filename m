Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141441DFE24;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=keFXYM6CEyKhQsmSMKRzL2wrlcMJ1i9mbIIopOZm1MCDJZfyU07e6WzMRrXci1V6vwLhz+wezrtJ4D8UlcEuJXHDzhMK+bFeQv3jRG1XhQDRa+1WFvjeBWBhr1C5KmGWcXPlZ3kCVc4uR2YAY6EMTXYrmD/dvvYhOnc0WbFJUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=Dj95o31GQqsBMKISFvlZUrwyZKzM8Z7Ckp1HHM8MZl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RH2JmaofZCXg7Q2e6BJ91bNli5+WPvNBgJsuyusaWbpLkDzVT/7McjlsHkEGMLFRl/MIGiAWm05+7Yskkl+Nuc3mb44GMNPPE+fNY6Vej8qLuth13LNz7KmEvhokKvmg0WXsQrTKfjwjoR97tzwYbvMQJANwf+eDTAGgcW+x5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUT9cVog; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUT9cVog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A9C4CECE;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496846;
	bh=Dj95o31GQqsBMKISFvlZUrwyZKzM8Z7Ckp1HHM8MZl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUT9cVoguQMfcO4rnNpP/A0W+gScXmM3VBfvTC/+c5SezaK8kaq/I5lyq0TeaujxK
	 CkxqUqQ+sDXzUuRngpx2Et4iTn0Lp6bwU2diUGhKi5U46CwEp4MoBniatz9dWTqdDE
	 L01X4uExHij8kZaNlSKRrAqbYVDDTNOvov6T88do3qF6gr3T5svixkLZZgjcDxofMK
	 19CRBfk3Iz+cI8dXUOBFzfP6/HoZVbS96D7j0EyBwfjZx17NGSiYGz2CFFmEPvuInE
	 PSCMytq76LcIqWCGYD9RlZAw8X62Rmzw2XAZsNqlU2ekGrLadFRU80AkQ/q10ddxbO
	 wo4dNu/movwkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BB0ACE0B68; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst
Date: Wed,  9 Oct 2024 11:00:40 -0700
Message-Id: <20241009180045.777721-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the rcuog kthreads to the list of callback-offloading
kthreads that can be affinitied away from worker CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index b6aeae3327ceb..ea7fa2a8bbf0b 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -315,7 +315,7 @@ To reduce its OS jitter, do at least one of the following:
 	to do.
 
 Name:
-  rcuop/%d and rcuos/%d
+  rcuop/%d, rcuos/%d, and rcuog/%d
 
 Purpose:
   Offload RCU callbacks from the corresponding CPU.
-- 
2.40.1

