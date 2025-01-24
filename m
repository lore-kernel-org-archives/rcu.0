Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBB1D5CEB
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683930; cv=none; b=drXDm48QqlmlkNz37mRoc3A5plXJcHjkutWej+qt/btk3YCd2e/N6T0Em8cUeVdBJxi/RqZHg2j9IC1hl9dHp8N5g8Rqaei/OGWYNnZ0DVd9Cx8URC05Aw6NGe3Pvk3Fd8PBxrHVg4F9ChxVLspMOw40XTmY18F7aevmO2IJ9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683930; c=relaxed/simple;
	bh=2/LB3V5JWdcgf4tsAt88qzoc3B9PT+ZPjL3M7JzTYTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Geh0mt4quY5bKVaXXWfax+fQfVn/3N3ctcDopIV9uRWxMN4be3YhgyvwHL5rlDoMmULOmP8PRfRV8oTa49Je1mFyJMgTOyg4GTRTvfDrFYks9Uxw2j2Q+71DLcUOA44r5dD60Qq7y2I8wXg86bNLNnZAWwgzZT+XqQSpyMQX5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=FRq9ATeL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FRq9ATeL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b9ad0e84e6so177567285a.0
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 17:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683928; x=1738288728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOszlMe/TkxR9TrVzVzkXceOdLnBKIK5m4j/zRnrkWk=;
        b=FRq9ATeL8byd0qZjRMKs5GoVDNwzxC79MSg+ZyeqO/OzOzHeGIX2bSn+qMpf1xifv0
         6XvN3iMkrle08eJu/Fb3gBqaWwq/zNK5v4MvfGFeEn1tGkOSh3WAT7Y1nFxN5IB2Jb0n
         ETVwM6N/f0Ly3R85j6OUDKXUlXuDNbNe2hfJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683928; x=1738288728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOszlMe/TkxR9TrVzVzkXceOdLnBKIK5m4j/zRnrkWk=;
        b=fFUd7stzst1+mBfMsZ2VqF7cStk1ZPEXsjzNctZICJc2Rqn0pZGCeejayiqA2FDgg6
         AsooyJZqdqeXRKfKr1XSNA3q45vX2DeIvhl8s2ZpDVK1Ey/meKMdiwNS6c9TauIo3CFp
         FAiNXdDKHwlOCnhs0h7nppZDZMM/IFAD/0IEuy5lG1ER5suhLzNki5hlBq4CNY5r8XlS
         fOMM1kU3S8VyqDlIm0bNQAO4ibPyoh7yxIRIdyh+V8sLDMhlGOM5/iTpg6wOIXtgBYAO
         onQOpzbUEVoSVHoovpVhLcw2xZ83qo503R5W0XevFDw18iJAMVgXKm+rvNhEVd2qyyd7
         tTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCVqn3Dtw2070js3YKDdx59Kftc9kmqwdljRyaliStfHgd2qmJRIYuCb/o/eoFCBRM0s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZN4LPZ51iFHqXDD37CrPcBZsF3NP5MSJnGSh7TsGCCd/DTMk
	EcHgrRJ71w8oM1y8FvNhFYHGUI9G3St3Bwx3VW/M91tNO13yWEPAAp/1DCyjE8k=
X-Gm-Gg: ASbGncvg1d6BXoBzyYQ9tNw49sbjPR4PXYi3JqurAscydV8by7KHIVW0jw9rOT4lczM
	JuIvO4pozrQEQYXCtUaCFIfqmlQlh7TEu4EVG9qkZH49U35852sHFg1+zhOTKe99IVefhpSTBZf
	oc09KTO6sJMLjkD4CfudBmxz53ouZ9o+S7Z53cQpooW/g6q6q5YrLv+L1tOoZMQQy2CuvcgyVxi
	kbdnHn9oNUgX5mIJQN0JMKtRX5Ei5ZV+19tTHDgrkvGnlMh+bOfX/smQPtAu5+aPM3oTpq6gj8J
	QzlDk4Lr8m0REHpp3EKQKcf9Dr5JZMg4o8zihBDTRZ31oDM=
X-Google-Smtp-Source: AGHT+IH9ySNTqIGTKZEGcsDbyErRXUpqlMVIGd6POYjLkXuAG73cMWZAVXL3Cixc0SCiAmr0lb4wWg==
X-Received: by 2002:a05:620a:2b9b:b0:7b6:d1e1:a239 with SMTP id af79cd13be357-7be631e58d9mr4060955685a.2.1737683927847;
        Thu, 23 Jan 2025 17:58:47 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:47 -0800 (PST)
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
Subject: [PATCH RFC 2/5] rcutorture: Add a stress-ng build script
Date: Thu, 23 Jan 2025 20:58:33 -0500
Message-Id: <20250124015836.732086-3-joel@joelfernandes.org>
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

This script automates the building of stress-ng and can be run from
any directory. It also support cross-compilation. The output is placed
into the initrd directory.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../selftests/rcutorture/bin/mkstress-ng.sh   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/mkstress-ng.sh

diff --git a/tools/testing/selftests/rcutorture/bin/mkstress-ng.sh b/tools/testing/selftests/rcutorture/bin/mkstress-ng.sh
new file mode 100755
index 000000000000..e5a19cca6923
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/mkstress-ng.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Clone and build the stress-ng tool, placing the binary in the
+# initrd directory. Ensure binary is up-to-date.
+#
+# Usage: ./bin/mkstress-ng.sh (run from any where).
+#
+# Copyright (C) Google LLC, 2024
+# Author: Joel Fernandes (Google) <joel@joelfernandes.org>
+
+# Get the directory where the script is located
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+
+REPO_URL="https://github.com/ColinIanKing/stress-ng.git"
+SRC_DIR="${SCRIPT_DIR}/../res/stress-ng"
+INITRD_DIR="${SCRIPT_DIR}/../initrd"
+BIN_NAME="stress-ng"
+export COMPILER="${CROSS_COMPILE}gcc"
+
+is_statically_linked() {
+    if file "$1" | grep -q "statically linked"; then
+        return 0
+    else
+        return 1
+    fi
+}
+
+needs_build() {
+    if [ ! -f "$INITRD_DIR/$BIN_NAME" ]; then
+        return 0
+    fi
+    if [ "$(find "$SRC_DIR" -newer "$INITRD_DIR/$BIN_NAME")" ]; then
+        return 0
+    fi
+    if ! is_statically_linked "$INITRD_DIR/$BIN_NAME"; then
+        return 0
+    fi
+    return 1
+}
+
+if [ ! -d "$INITRD_DIR" ]; then
+    echo "Error: INITRD_DIR ($INITRD_DIR) does not exist"
+    exit 1
+fi
+
+if ! which "$COMPILER" &> /dev/null; then
+    echo "Error: Compiler $COMPILER not found."
+    exit 1
+fi
+
+if [ ! -d "$SRC_DIR" ]; then
+    echo "Cloning stress-ng repository..."
+    if ! git clone "$REPO_URL" "$SRC_DIR"; then
+        echo "Failed to clone stress-ng repository."
+        rm -rf "$SRC_DIR"
+        exit 1
+    fi
+else
+    echo "Updating stress-ng repository..."
+    cd "$SRC_DIR" || exit 1
+    git pull || { echo "Failed to update stress-ng repository"; exit 1; }
+    cd - > /dev/null || exit 1
+fi
+
+# Build stress-ng binary if needed
+if needs_build; then
+    echo "Building stress-ng binary..."
+    cd "$SRC_DIR" || exit 1
+    STATIC=1 make -j 8 || { echo "stress-ng build failed"; exit 1; }
+    cd - > /dev/null || exit 1
+
+    # Verify the stress-ng binary is static
+    if ! is_statically_linked "$SRC_DIR/$BIN_NAME"; then
+        echo "Error: The stress-ng binary is not statically linked."
+        exit 1
+    fi
+
+    echo "Copying stress-ng binary to initrd directory..."
+    cp "$SRC_DIR/$BIN_NAME" "$INITRD_DIR" || { echo "Failed to copy stress-ng binary"; exit 1; }
+else
+    echo "stress-ng binary is up-to-date, no build needed."
+fi
+
+echo "stress-ng build process completed successfully."
+exit 0
\ No newline at end of file
-- 
2.34.1

