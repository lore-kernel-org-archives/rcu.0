Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693AD299AAC;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=SS5MFgZ1ONRjmPw6+ZWiZUNFw8RFV21JG/P2aLxZQILD+U5hJ9Q5JITKZeGBarWjvIx5w6BWXzB8XQY1/xwNj8cb4/Ifg0w8OjdFmLL29xAxl7E5geGciZ7ZdzWjKxkDG7De6504tS8pNzuKSqqwsANt3wzMTTmcpvn6CDCdf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=7YZdNIC0rO1kY2z4VeiAJo6ZAUYFdwgJosKft3KdMEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ct+59oq1MBkUMJLgyqD4I1c4mv50rcDRJ3Tdje71qddvIrgxDpeSo6+zQ8UuRjpCy+OgpHT6hBrMK/1I9btjb/QT5pNADg9VJgAtAymutPlb3jAYnudUTUkmp8y+zc/5/5vXgebAOeOV+J8AIqZvqoqp/c3RIliZaGFTRqH7UGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYxI7rYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYxI7rYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4299FC116D0;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035640;
	bh=7YZdNIC0rO1kY2z4VeiAJo6ZAUYFdwgJosKft3KdMEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYxI7rYZoe+yfh44RoqV8JAY4a6lJ1yMD7EC2R2yu4wQf7ER4gat0pvmRyIrjlEU8
	 9X2VihoIjuyeEV631B8Glje0Z3zasU+g/0retplmk/3VX83Tkf2bEZvXciD8mSbzC0
	 6sG6wbCvIMJ9/nM3kjv9JOALFbiswnCfK+Kq95hYFOEQUV5TEEb9Jkz+BihrvmJHbm
	 7g+qiusgv99CrCfiuRxe87S6Fl3PheBiKv1PhIig5hyz8p7cpV8oyr8OCHCIw9TVQL
	 wSk3vAWJb2dlR3LqobJ9+dhMcIAC9eQZOSyhjOFEqCh5iAqwrYJBhNwTQWPxtxecH8
	 SBpeoerYL+KLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97D45CE1079; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 5/6] torture: Make config2csv.sh properly handle comments in .boot files
Date: Mon, 29 Dec 2025 11:13:57 -0800
Message-Id: <20251229191358.693753-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
References: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As in strip the "#" and everything after it and *then* tokenize.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/config2csv.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/config2csv.sh b/tools/testing/selftests/rcutorture/bin/config2csv.sh
index 0cf55f1bf6548..aeab4d6f11ad2 100755
--- a/tools/testing/selftests/rcutorture/bin/config2csv.sh
+++ b/tools/testing/selftests/rcutorture/bin/config2csv.sh
@@ -42,7 +42,7 @@ do
 	grep -v '^#' < $i | grep -v '^ *$' > $T/p
 	if test -r $i.boot
 	then
-		tr -s ' ' '\012' < $i.boot | grep -v '^#' >> $T/p
+		sed -e 's/#.*$//' < $i.boot | tr -s ' ' '\012' >> $T/p
 	fi
 	sed -e 's/^[^=]*$/&=?/' < $T/p |
 	sed -e 's/^\([^=]*\)=\(.*\)$/\tp["\1:'"$i"'"] = "\2";\n\tc["\1"] = 1;/' >> $T/p.awk
-- 
2.40.1

