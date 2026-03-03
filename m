Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB7373BF8;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=WNDX27GHNKjjNF5/Y52gj7RYDOd7o0ULbIHrzCXsh9VYDOGTR9XTagqfUMgtzeQKbBWapeh+47cxDhZLHXAGU+4nx/HGLxjj4gTXfrs93twriw5X5UPtTDSHU4z8esmlJP2x2p4ceG10RgmIKVk/g/RO59oF7+8kH1PVWeD9afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=VoNcyuhOY3K/ZuzJbmeGoA1eSI0q+TFLh+FtBvEGrZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOMl74fDAy6ZcX1OSGzZAJ/S17Bpj042ISbKsXdkIloYIgD27wG7fe9FFEo1Wtw/jN2MtFHPIZqdbaqsWEAzDOwnau9WPSnAzxtIT+Q9B3CTQ6MsY3TH9doo5zKzuncCRdupy9e8ysd/dU9G2Yj9kvRZdsv9rgn0TQxToqfvgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7/7Ir2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7/7Ir2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67232C2BCB0;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=VoNcyuhOY3K/ZuzJbmeGoA1eSI0q+TFLh+FtBvEGrZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7/7Ir2n8BBJTlz/IdiB+M1HspvCgdYeKBVg/Iw+s8oLku3V6J6HnJsH1Y8sDtvsN
	 wubD+zAckGP0JzRKTUsbzBDBzOkKtsXaNidwINL8aiEKVIxp3yFTIvE373WtmiYIpi
	 ref/fRnKbga9YPDhuFvaFtD/1/KhXAyIFtfpTUXnJKhmSVCAvLJXNbmPesnXkB1iTQ
	 pYX754z4WN1P8bGD4ZXH5UDmxZVFSZentIFgGk4XphY2WNusVGSSEYcPrGUU+9uf3g
	 QGEOEm/7JEjxxH+uY6BJocgoD3s/DEA3wp/Xnky7Aza5DehdRO8DGwSrWmtQO2suFV
	 LOQjfGNXiE8zQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7119CE0ED1; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 03/11] torture: Make hangs more visible in torture.sh output
Date: Tue,  3 Mar 2026 15:50:29 -0800
Message-Id: <20260303235037.1967017-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit labels "QEMU killed" lines so that they will be picked up
by torture.sh processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh   | 2 +-
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index de65d77b47ff7..4791774b8485a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -49,7 +49,7 @@ do
 		then
 			if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -eq 137
 			then
-				echo QEMU killed
+				echo "Summary: Potential hang (QEMU killed)"
 			fi
 			configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
 			if grep -q '^CONFIG_KCSAN=y$' $i/ConfigFragment.input
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 21e6ba3615f6a..be1e943ca4d51 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -113,7 +113,6 @@ then
 		then
 			print_warning $title `cat $T.seq`
 		fi
-		exit 2
 	fi
 fi | tee -a $file.diags
 
-- 
2.40.1

