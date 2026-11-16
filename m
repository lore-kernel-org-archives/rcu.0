Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849992;
	b=sHKqw4NCq2vWTjV9GgxXS3MsLoG2Jql0eP6OtbkrB614v1XVCK4HN1LFIuaoBZGkXrCF
	 UpgcUjbO07t1EbDTroiyfgqxQ8f1UymrGUYKNSxXflgfvzBjMYKmvVMpQx/wi67DVd+Tv
	 ykFWEq0/9NDNO8FzFs8XA7SI1eO5F+BlV2XeMCZ/9/OvIYQPmGPlWSR4Ps78bG77oJMO0
	 y8gQrP1kaCj7h+MB/N758y8pwwMMyW1nhoDYOJyXk/kqEJuOErhNuAbxbPRu38qescpH5
	 2vXvICUMGPo2nwEibmCHyCeZogYmB/ISfOdzyTnQc4ZlFj5kAEP9AtrAUZmzI7YrdPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849992;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rIBBEzRt72FhXx3DW1CqFstT0cyrNv/BtocHWknVpdg=;
	b=YOxRGJgHo7oJkwYwqXrok+ZptFCZagbabq09SLpEAD42QQSzGwrMu/gq5f+RhTeMMq6W
	 lBMPJPPWqO3gH8OQYtYUrkg6a8Sve19MqWjLqURXOz9f+ioYwb4Z4cX51/dniasYVfJtf
	 Q203rFutl8x/qZRG3xA9TdZmcfDX49bL/wYdjC1bpr1fn9gI88o7dR2/3NsZAoYqAM3BU
	 M8Y9VdPJk6g4AGLyo0r5zBMIrNm/YpjrjVpjUylGh//iMjONTgQnj3h+UVz4ItEysIaxN
	 +Rf/IXTWgXFXwfVZrJ9OYNQilwd1fctOzYgvzqBCtgD4sUVROCma/tqCp3+OWErCt5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THE0jom8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA390606A32F;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THE0jom8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706031F000C4;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=rIBBEzRt72FhXx3DW1CqFstT0cyrNv/BtocHWknVpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THE0jom8KK0i/Cw/p/xoyb6LGeO8f048V5UFFsYm0993JgRH5JB489Vm61V4ly/0R
	 bx878cfOrg1tHIkBwG5T6dFx+4gPgjBgyZyO0Klx6oOLSAivxlnKTEl+pv3AFLgKD/
	 AR5pY+LbU1pl0LbWQlfk8mCi5Jzl+RsRt2Xu/N/dVNK1dJj6TsvQ6vCSC0JyB/MtbJ
	 6uThizMSdKI0EyYDEdlrx3KmkLnKLPu8Ps4uEp8Z56kesQVV66/SpfXsPVPk2TYpZ4
	 FMwKRrbWC/K0kxmFg84UTmIML7SViqVZXpSa8TWk3XgMDustJ8fAZh6e4gDBUNkM//
	 OGjgGxHmDxqcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 426EDCE097D; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH 1/6] MAINTAINERS: Add Puranjay Mohan and RCU reviewer
Date: Mon, 16 Nov 2026 09:26:25 -0800
Message-Id: <20261116172630.3845508-1-paulmck@kernel.org>
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

Puranjay has made substantial contributions to RCU over the past year,
so it is time to add him as reviewer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..6ebe13dce75dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23485,6 +23485,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
 R:	Zqiang <qiang.zhang@linux.dev>
+R:	Puranjay Mohan <puranjay@kernel.org>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.40.1

