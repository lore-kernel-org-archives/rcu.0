Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7F2FF67D;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190474; cv=none; b=i0rOmBbLl34QUw7jjxHQdALKEz6VK1VAIJG/nORuqECz576IowhTprY06vusL61IagOgS9uNtfdaAxF9BEKE3DljGgC8GPcevj6f2FWWuw6oag77wEPCqnsG4XjOBhuOUCPlBY0Yry9T212OXrNgUE9okZJ5L+0yqOirsBGwlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190474; c=relaxed/simple;
	bh=F/z26h8mPlHeVBL0/k4VrUv9IHioXLm82pCiazSq9bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUT4+paTkjCgiqL6y0kxlfaw6gSR7s2uybNubWNDr/6tqHL6dZW5VlMpXJJQFwx4GiQHndlEdGxSZZFC4C6qJyLKWg+pjKUnLg9Mt4dZbpDiW5BOYAgYmgPMZoWBjS0hhUBih5TF3ettBCMsDbqQ0u5Lbzx/9S230eLjB4rvojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHmnCxT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHmnCxT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D069BC4CEF1;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=F/z26h8mPlHeVBL0/k4VrUv9IHioXLm82pCiazSq9bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHmnCxT+Q9crZ6WfiUy5uHCIz7VtundJWBuNg1CNXAXbwrugd+7aGswSEik0Zbmb0
	 j67N4x/ycJ0oGBrLUiS5uwKKn8QB95kqfYG204+dfkMXjCkSriBC+rrjG135gsxSEF
	 IEo3msouLekmJckpIatF3pvUoqW0XbN9Q4QL0+YchsIucpXGGtCsdSGenPYTDdGZcx
	 Z2+sDtOKRY4TumM5ne/C1Fe6exQIh0B5MlLS8IvLjojXSccvgNxv0tZKCWjbBoizba
	 TmTR2wJUFcMBkWxU5X28SrEGx/Bvhmy9+OAdG7ZadHKAS0+uo5hlVAALACOFNtRRH0
	 cJRu9ySPS36NA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCF24CE1109; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Nikil Paul S <snikilpaul@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 8/8] docs: rcu: Replace multiple dead OLS links in RTFP.txt
Date: Thu, 18 Sep 2025 03:14:30 -0700
Message-Id: <20250918101430.2592294-8-paulmck@kernel.org>
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

From: Nikil Paul S <snikilpaul@gmail.com>

This patch updates several dead OLS links in RTFP.txt, replacing them
with working copies hosted on kernel.org.

Originally posted as part of a 2-patch series, this is now being sent
as a standalone v4 patch to avoid confusion.

Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/RTFP.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index db8f16b392aa6d..8d4e8de4c460e6 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -641,7 +641,7 @@ Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
 ,Month="July"
 ,Year="2001"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2001/abstracts/readcopy.php}
+\url{https://kernel.org/doc/ols/2001/read-copy.pdf}
 \url{http://www.rdrop.com/users/paulmck/RCU/rclock_OLS.2001.05.01c.pdf}
 [Viewed June 23, 2004]"
 ,annotation={
@@ -1480,7 +1480,7 @@ Suparna Bhattacharya"
 ,Year="2006"
 ,pages="v2 123-138"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
+\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-131-146.pdf}
 \url{http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf}
 [Viewed January 1, 2007]"
 ,annotation={
@@ -1511,7 +1511,7 @@ Canis Rufus and Zoicon5 and Anome and Hal Eisen"
 ,Year="2006"
 ,pages="v2 249-254"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
+\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-249-262.pdf}
 [Viewed January 11, 2009]"
 ,annotation={
 	Uses RCU-protected radix tree for a lockless page cache.
-- 
2.40.1

