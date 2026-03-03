Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA6374E6B;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=Fdst+7TCylOXHISVTryWkt3A5hWfpzW0zy0aU6xLl1HG3huYaPMPSH52rqv1vr+gvNE9uTk5/mBjnFgxSj6z8gbS69svjoQ+cJc9DFzo9tUn6A8qLoLq2pZktTztVQCBk8WOgpSOBdSSHeCQA+F9yEb08pKQnshULrsesDMDQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=N9cQxTNv/8Ij3OtaHR1FblDaP7r73JkKScSsGG04tCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSdOwJ6hh3b27j8E/yQNBpI0KpdMUdoK19eeyW7vNmfW9AT+6sGt4ceHN/tjVPDDdlWU50RGZuPhvwQQlYD/r+e+NrQpTxYEODgOLWl3Kx01SPQMR7jvd4Ndx6V61zlDEIouGX/vZtYryuvxL+WUSEekGUo0rEpSKDbs5XiY5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf0qSk13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf0qSk13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACB8C2BCAF;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=N9cQxTNv/8Ij3OtaHR1FblDaP7r73JkKScSsGG04tCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zf0qSk13Sozp7Trb0u0EbE35V1UWFqW/Tqxu9b4/kPsqqQIim7AGJz061j+DWPfFc
	 4yZ0G765hEG5kekOY5q00SqNMOv+QhgtV68fG3bS6anYsWFkUJBSkxDgq5AhbTHYR+
	 HHvXJBhdW0gkov8cPNFauXvOBx+XnKufC8JgphyifNZYk5XcSNcWYksGB++qjpZIbx
	 zS24fFpvmlPc+aNTNR2SwR0rB1KUZIjrG0Qeg+5kWcBNbAIZ6xkFP6a5PPPbsxaTfX
	 rqON1FJqbhCAyboP3qwjRPSf0phurX0WsOnId754ayZLdOyj4ZSnld412Zb5p4fM02
	 OYT5DL5ldF/gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBF48CE0EE1; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 05/11] torture: Print informative message for test without recheck file
Date: Tue,  3 Mar 2026 15:50:31 -0800
Message-Id: <20260303235037.1967017-5-paulmck@kernel.org>
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

If a type of torture test lacks a recheck file, a bash diagnostic is
printed, which looks like a torture-test bug.  This commit gets rid of
this false positive by explicitly checking for the file, invoking it if
it exists, otherwise printing an informative non-diagnostic message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 4791774b8485a..63bbbdd5f4ef3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -39,7 +39,12 @@ do
 		X*)
 			;;
 		*)
-			kvm-recheck-${TORTURE_SUITE}.sh $i
+			if test -f tools/testing/selftests/rcutorture/bin/kvm-recheck-${TORTURE_SUITE}.sh
+			then
+				kvm-recheck-${TORTURE_SUITE}.sh $i
+			else
+				echo No kvm-recheck-${TORTURE_SUITE}.sh, so no ${TORTURE_SUITE}-specific analysis.
+			fi
 		esac
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
 		then
-- 
2.40.1

