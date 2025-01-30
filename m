Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BE1F153B;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=WGQ6ZmOYy70it6lCc1vw7N4IsgtpFvYjH8C0mHFNJE2FQVs01bAz4JoU/vvU9RT+Kjk417O/tNuo8dNvTFolc8LKGkH63Vx+w8mymtRAgsX0CfqMDoYHbEOqVb8BF4SxPKb9VipxMBcrHGIErYBfYbi193aru7yOrzi2gEEKAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=iRGkXddEo5weo8EwFGAVTO/NT+9yqSruGHOw+ZNR+iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GL2GRIXH/+lLhh1RH8JVYTYRVKkPYfN9Ux+ndm7w0bijnevkJLAJ/I9EmzPvOFpQZGbWscgaiEQCVawuNmEmxDjP2SLFPmJEWf5wqitECO/yIg2U0PzhF2PcjZiOZcJNnLQcaPR/UF9Ez5Dhb5XEf7J341FWP0jY9htyNRrEyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q88Z5GZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q88Z5GZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28D1C2BCB6;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=iRGkXddEo5weo8EwFGAVTO/NT+9yqSruGHOw+ZNR+iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q88Z5GZLNaCvV6+UoXxW9hb7otrzk8cycRJtN2k37v1rQQl8XmOVYTPLDKK9cbahy
	 uTCJFt+Xd/uh+g+P1+fqqYYoMOGUJp9fr2TIi7AwkUd/0BABmw/qKDNgYkc0TPjyCF
	 SqfqkkMmSnLQFhCUZtkRSad3LLIPlwvRlaoCaJ/r2wapZ2C16LuOjZfLS4AfGjUS0S
	 Tz941BRbn6PFIFcaYwLNPu1n+rXETxS3dNtmhCIt9ZulXBv5jgbQny7OAXhHk6P4+n
	 53OzTXo6CBdxiyss0rEqOqZQ2qOL7nmCN/j4+MttBlNxRG+hL/knIY0gOfuc6pQ9Li
	 K+NEAZVO1LB6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C777CE398B; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 17/20] srcu: Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc
Date: Thu, 30 Jan 2025 11:03:14 -0800
Message-Id: <20250130190317.1652481-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The srcu_read_unlock_lite() and srcu_read_unlock_nmisafe() both say that
their idx parameters must come from srcu_read_lock().  This would be bad,
because a given srcu_struct structure may be used only with one flavor of
SRCU reader.  This commit therefore updates the srcu_read_unlock_lite()
kernel-doc header to say that its idx parameter must be obtained
from srcu_read_lock_lite() and the srcu_read_unlock_nmisafe()
kernel-doc header to say that its idx parameter must be obtained from
srcu_read_lock_nmisafe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 63bddc301423..a0df80baaccf 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -402,7 +402,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_lite().
  *
  * Exit a light-weight SRCU read-side critical section.
  */
@@ -418,7 +418,7 @@ static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 /**
  * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_nmisafe().
  *
  * Exit an SRCU read-side critical section, but in an NMI-safe manner.
  */
-- 
2.40.1

