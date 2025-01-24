Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC91D63E0
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683933; cv=none; b=hqIXWLfwQ4MEg5Prfev+CNKDvhB4dTOKtQ1JWuhlwly8PYpCgPUBwwh9Bu/iVMEw+/3bSmnSVtYdU9RXNvLIjqY6KAgOgaUjRIN6QIbl9CmRY1bwP1sgnDoYdgAWUSsnH1KOWkB3hN6uvn3eZkhZUs+avQXtlQ17zytJjfa15zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683933; c=relaxed/simple;
	bh=sh2unf8Xeoi6Q+VSDQ1CR6UU8KtcNX5rCfAveB7F7g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjzmTAaFPA1tjuC4rIQ+JD/9VZA3MR686sbpxMyw2AyZNVkE7FlygHVgECQl5+Wnd0/6sb6TlOAT9AEgYTtE5CIi9iTPDyxtHSGVt/bfsCwsTZOfSiV7Q8OhIdzvwVgrc+Hf1PkgvOECkDOjJRSolDlLi2xaoLMVFYG6bExRpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QM5Znsjg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QM5Znsjg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6edb82f85so220751985a.3
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 17:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683930; x=1738288730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRHySpG58abjuaHF+3dQ690cqYR/gs8q/AgyFnz04uw=;
        b=QM5ZnsjgRpfmjA2wejPdBLDlwknbe41yevnkg0RAp6+D9/52YSs3VwhNdspOHW5dMs
         sYD7zYueoMdANFOKNaDTCz96Ml9TCsImM7mbwnJ6CT7q6Pti220YKutJDQvKp8RaDO/Y
         wAjLHPk40ApzSeJw8UQqTxr9ej27gYBfUoWAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683930; x=1738288730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRHySpG58abjuaHF+3dQ690cqYR/gs8q/AgyFnz04uw=;
        b=NCKZwUXVo8tZf4cz1kQbg55LCeRQfLDINN5YzEe8m2k2KzY4Y8B+dBoMMYYdrghL7l
         N0MK1aN9tL9Lx3CsdCSg6HLsSV+hPIrh+ff3icjK7sRZW+fWOnuWelqmEkVv6xIu6mYq
         4wlNyE2E39Tqp5y1oq3YGSPziWKy5UPYRSfFfnz5t663Kp3+GaxuM83Se6cJK45HvPb6
         jz+u9kq6BdrhadN7hjPQzW63ad3jaCSL5OtRxjAn5juAn/c7BpYkijTv+yggbeaH4q7W
         uzR7KP2khBBBEOkStQgSHnvoAp7gECFSPMGNrI+A0VgCYlBJ2dyf1T3Hssr1ACKaSIHO
         z24g==
X-Forwarded-Encrypted: i=1; AJvYcCVCG0i9YeiWv2zt/Ye7InLGgvK71k66uxGWZNU7j8V/1vbZ+obstkOBG/3sxmdlkZb/3T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPyl7qEdmBfUpo3N4G+NcbCMF1qk87p/xnd2z7cil4meBqfm7
	8tyDK8wJ5ipbW2r54I7wn6z2wwwUlnoLe5eKn2penfimV4NGaMyvxVOQfWGo2b4=
X-Gm-Gg: ASbGncve7KIGvHrRlv56grZCWmm+fzt5bh2v6ki1ebfpHTPmpwWckwA9upm8O0jMF0L
	muxpC0SU7Rs/1KY5Et0EClbEZmpk9UG8uE9k2w8ZTKEx3mSDs3773ZcOwLdcnPFKcKcciSXx4uC
	ae426sdTXIvZENb8suuPZzp9E1W/obq8d9CEibOaj1Ew4NZPZZIC2uSy3Q1wjyyCxQQUYSyY0g8
	PX5HfPwUHqU8mjiVBuGGpWeZKE2cMvUrvcmxy2r1nR+6CoQ3Dim0K6f5ukdJufAcisHy9rsaB56
	DKLwdu+/Ni1vJArIHHhfn5nEKpeRQAkApASStd4P9okyZxQ=
X-Google-Smtp-Source: AGHT+IHaXKdjk1Buyn6a6Xv4FIqoSmZ7YVk5544zLuI+aKxxiCP2bXeVGPwOfxrj/Gksc+jk8pGH9w==
X-Received: by 2002:a05:620a:440f:b0:7b6:7a87:744a with SMTP id af79cd13be357-7be631e712amr4443518985a.5.1737683930638;
        Thu, 23 Jan 2025 17:58:50 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:49 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 3/5] rcutorture: mkinitrd: Allow to run optional commands passed to it
Date: Thu, 23 Jan 2025 20:58:34 -0500
Message-Id: <20250124015836.732086-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed commands to invoke into init.c via mkinitrd.sh args. This
allows init to spawn a child process running the command with the
required arguments.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index f3f867129560..4ba5e962e3cf 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Create an initrd directory if one does not already exist.
+# Usage: mkinitrd.sh [command [args...]]
+# Example: mkinitrd.sh stress-ng --cpu 1 --cpu-method matrixprod --cpu-ops 1000000 --perf -t 5
+# Note that command/args are optional.
 #
 # Copyright (C) IBM Corporation, 2013
 #
@@ -25,7 +28,9 @@ echo "Creating a statically linked C-language initrd"
 cd $D
 mkdir -p initrd
 cd initrd
-cat > init.c << '___EOF___'
+
+# Generate the init.c with optional command
+cat > init.c << 'EOF_HEAD'
 #ifndef NOLIBC
 #include <unistd.h>
 #include <sys/time.h>
@@ -33,6 +38,29 @@ cat > init.c << '___EOF___'
 
 volatile unsigned long delaycount;
 
+void run_optional_command() {
+EOF_HEAD
+
+if [ $# -gt 0 ]; then
+    # If command provided, generate run_optional_command() with the specified command.
+    # We use printf to generate the command and args.
+    # Example: echo $(printf '"%s", ' cmd a1 a2) gives: "cmd", "a1", "a2",
+    cat >> init.c << EOF
+    pid_t pid = fork();
+    if (pid == 0) {
+        char *args[] = {$(printf '"%s", ' "$@")NULL};
+        execve(args[0], args, NULL);
+    }
+EOF
+else
+    # If no command provided, function will be empty
+    echo "    /* No command specified */" >> init.c
+fi
+
+# Add the rest of the program
+cat >> init.c << 'EOF_TAIL'
+}
+
 int main(int argc, char *argv[])
 {
 	int i;
@@ -43,6 +71,9 @@ int main(int argc, char *argv[])
 	for (i = 0; i < argc; i++)
 		printf(" %s", argv[i]);
 	printf("\n");
+
+	run_optional_command();
+
 	for (;;) {
 		sleep(1);
 		/* Need some userspace time. */
@@ -62,7 +93,7 @@ int main(int argc, char *argv[])
 	}
 	return 0;
 }
-___EOF___
+EOF_TAIL
 
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
-- 
2.34.1

