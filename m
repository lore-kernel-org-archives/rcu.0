Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D125485F;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=SUyCr4lB2cTnVus6ZP6qMRpRNZmVhb/Bgle1vDiaa9Kw3qWbokvgXaoeAL1HGRlWhRUd86Tny4gpCOhdGyfjuIOETIuKWGgz3F208khU70wCut3CoKVb04d+5AfPBDgHbGj4yyZyfBxnIq8bEeORgGPBczZ0UWu8KTaIqWJdcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=e8020D4IGboPZ/X1LsVXzWAnxHPKUMzBbRHImWEKJYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVQZlPQgEjIQmhRyZzTniYxdDiQAhfIo2ws0p+LJoT6obNfO33EmOu13CVYB4e7FRX7VPFkejlTOpajc7iijXcIVPSlDt7mR/SzGiTDa+iAtsDCpPbfmpAK/Tdf82RBMLeQY8maHDwObTQf5jSglxyYBXym8nhol6gpAWYzYmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPKlm9gG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPKlm9gG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC32C4CEF7;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=e8020D4IGboPZ/X1LsVXzWAnxHPKUMzBbRHImWEKJYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPKlm9gGdVL73JjwFhtHs3O/QVW70mnFFUYGUGjp1IXg7qe1EeNFuIxv8nqP5jmpR
	 opUhk7j4SuNXb0IQzalKbg5t5slXXAe9RiGhmOIDj3uf/8VJ6QLWf5uMQHKFmm5FMq
	 YlrblJuXvTbcPoPexwdsakPnLFhpAaZleQZz4V11QACH2Czyfp3ejBR/7qqXRQA7mc
	 hQRHuxS3VDI9/QnDnuRT8pA1mvd9dupLqExIeK8pAPvht6JkUicw4BgMQ+7G3KZEXh
	 oaBVY975NBJ1exoDU/WWnKGKTgcN0H9UU+eVz4QW9o1UTOabq4QR6fWegKiHU1P+E1
	 v5hOoqo+ASr+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C626CE160B; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 14/19] torture: Permit negative kvm.sh --kconfig numberic arguments
Date: Sun,  2 Nov 2025 13:44:31 -0800
Message-Id: <20251102214436.3905633-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit loosens the kvm.sh script's regular expressions to permit
negative-valued Kconfig options, for example:

	--kconfig CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN=-1

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 617cba339d28..fff15821c44c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -199,7 +199,7 @@ do
 		fi
 		;;
 	--kconfig|--kconfigs)
-		checkarg --kconfig "(Kconfig options)" $# "$2" '^\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( \+\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)* *$' '^error$'
+		checkarg --kconfig "(Kconfig options)" $# "$2" '^\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|-\?[0-9]\+\|"[^"]*"\)\( \+\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|-\?[0-9]\+\|"[^"]*"\)\)* *$' '^error$'
 		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
-- 
2.40.1

