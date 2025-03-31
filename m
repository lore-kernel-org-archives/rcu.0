Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23621C19F;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=MZnYOvg24xFRXbKqwg0xE5VX8MvFZIAG4iy0iKn4pC4Ze7TgGtjzHzbzkgQhLMOuNetpaf1yuGCjas+Uinpc7J9quP5B04e+CTPL6AfyMiBqQdptm2NObui4vEX8AC1JAqQOYMNJrL/5pJ2gAXfq68pCWc3mbT5HJ7VIEuTPzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=8uZuS6tsNAX55iuq0PN/d5fRZHlLZUjcbgoA89CQHKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrKM2tM1bpV74izFbwQVlOPy9n4nRTU8F/0myCesEUU1DMWWrUPr4rkS+gkhmM7Gt/kk6NODkVjfBl1wP2AeUz2sFcWeHq7aIhAwsYsdZMtk4PainfG4i2Q46BSqwlKM7eqapdSlw88gTd5c2OokqYbEsTDVBIT1o6krUxAgdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9cMM6ds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9cMM6ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3823C4CEF5;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=8uZuS6tsNAX55iuq0PN/d5fRZHlLZUjcbgoA89CQHKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9cMM6dsQA+Q0zWXNZAWnwD/moIcd6Z14QmtwiqqWK5ncFJUSSoRAvkABMrDcRbQO
	 kQURli3dFuuawAnJND/FSiDxMbKIBHqZXWtlz/lVMX1rxApgE89YVbA+xR6hsHHUaR
	 AdjiPZw1IVMNHHfPZMlPW5y/Dt+7vARI6bl+sJL3mcPgEfNYYR/rwusSTys0m65gTV
	 qUXu9EkXXEIdm+Lre1iDbaDS6JGD1Nk9q3nJPJnDwc2iqcrLwIR64GpQKjazNpsEEm
	 W+bCXmktK8qCtCdy1AxjUQlR1yX3L1q6Vvzt7P8rh4lfx5FPepDQDIjYhH9lS8z334
	 9xGj34mc8fjCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B6EFCE1312; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite()
Date: Mon, 31 Mar 2025 14:03:12 -0700
Message-Id: <20250331210314.590622-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
happened had I thought a bit harder a few months ago.  Therefore, mark
them deprecated.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad3317427..de8ed5efc5b16 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -838,6 +838,8 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
+	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1

