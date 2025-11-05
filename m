Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EF34B663;
	Wed,  5 Nov 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374741; cv=none; b=nPODPF1WJ3gcMpcA8nT2ghIAVoYRuXC+BoO2wlrNp371PIM9DeN1up1qDwtSRQ6Ba1ImothKHj0ue0lP7OayCWpiaGYvj2GO1pUIS6N79erl1/WCbNvXjvNccUKeAayvwZuyjm1w211xdPfZXWcNQGZxS1p2LNaEk3ENEWhVsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374741; c=relaxed/simple;
	bh=e8020D4IGboPZ/X1LsVXzWAnxHPKUMzBbRHImWEKJYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6iq2q8knb2o/Od3My9B/E2eGhG0hijAZhYTP9FyDve4cE6HlBaONzlEFxNE4ITSaY571Wc8MOts3WPzm7Hq3PfzkQBHmMpShMYflRcIqo4isNc87OpA08AJccQS57XbHZfZtT0bUaKHQRFr1CP1gDTTBOSZ0H0IjiHZTA5VuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqLfDi+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqLfDi+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81675C2BCAF;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=e8020D4IGboPZ/X1LsVXzWAnxHPKUMzBbRHImWEKJYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqLfDi+e330hGasXldyhEXJIPyW/8d6hgx/5J+cRGnuEkiAlLsWN+EV8gi2d26n2E
	 8KOTjOKpK9F7cul/tUu1XmALrc7+DHpcLz0LwuZZs+3Q+3D0vp6vtqjD2Ic5PZo21N
	 ZZDxvVJTPMkpNvgNOu3F5WxAqFr56cZUsRIRzsyKzWpLhnarRv8PtgO4/S2g5o/s7O
	 zFhHCQjlokyxnuXitSj7Lu7/I1I86xaS/o1ZVHQXGYcXU5/7qq/4Qscm0rk3Nt+qdt
	 pIoLSfqq4Ygd+hLq17E43KIhcJ4fKxYhs99Io611Qam4nKZW4qOxAa5WoG26HFEDaO
	 91zNY3muwaP4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A627FCE0FEA; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 13/16] torture: Permit negative kvm.sh --kconfig numberic arguments
Date: Wed,  5 Nov 2025 12:32:13 -0800
Message-Id: <20251105203216.2701005-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
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

