Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3422BEC42;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781643; cv=none; b=kEdlI1qdIMdl1bo69Jv4CsXuRzlfmQy+oJ9Jmy1A4I8Xm1c6W7yI7OOal7hifk12ivB7/oiOiZ3I8csn1mATNgn7YImGH1n071dpP7MFsr6HVpGvoOej0q0faeyaVIpn/sj1tXldL9kNvD85KoEV46Z6PJSIQM+emwa+P4Uu7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781643; c=relaxed/simple;
	bh=hiG2dozkfroWs4r9hztHnvCE1r/k/oQA4zHOw7idPa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0uM2uCf5/3Gazrd9fBfiLcFXehzN6WrhVdUFmkO45AvzZIS5BtJ1NY9Fjdyx0OXJSRUo2wDoLnCClNmka6KS+I8X2mKYEeex2ODiDtJadmBJ3l7zB0lokYP359uut/y6LjUF1m73R7FHvonY666m2iTr30JlTcqScALllkydIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM9/e03V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM9/e03V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37103C4CEF2;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781643;
	bh=hiG2dozkfroWs4r9hztHnvCE1r/k/oQA4zHOw7idPa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EM9/e03VJWoLnlcpDtYjQSmdanC/70FI2eFwi6OxziukOzs3oa8yaed/9ZI9sAGcs
	 pMHODPzHbBBQ9yx3tLsfUqLqkSQJrD1BruJe6AtgoX9fK0hYxektTZiJAf8DOp0JUC
	 heVjaySDhmgk7PtDFOLG3k9xB/VA62EuLKdarptPzO6IEQNWeQr3jXr7hiz2EpWTC2
	 IgiTqc5MLKlHJct7o3KvKlgW8+SzOuFOc/Sm3hpeb8PS9npBytVzVvWYWTQhSoi1or
	 tDRijLoUenG93lnJm2cTElheJPs5u8bVYZ/JeagQvKewa0iHzdZygnevU+HR3FL3C1
	 VsXFp0/O0XmOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C350CE0C51; Tue, 24 Jun 2025 09:14:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/5] checkpatch: Remove SRCU-lite deprecation
Date: Tue, 24 Jun 2025 09:14:00 -0700
Message-Id: <20250624161400.867880-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that SRCU-lite has been removed from the kernel, let's remove the
now-redundant deprecation from checkpatch.pl.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c2..867c7b6fd839f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -857,8 +857,6 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
-	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
-	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1

