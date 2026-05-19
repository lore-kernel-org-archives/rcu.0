Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024983B52F1
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219934; cv=none; b=Wn53UpiFxmR8pspZ/b5WTCRNbUK2wWoPm1YmqoB3Y+pffnJ1r3AvGwBLKCIMngkJbz/9O2mbjEYkkF6axZ2j59CXpf6Wv/X1qtc5iTV7HirbYcM+bOpi0QZ3EFpxL8KdUqDRIznLUjMqsNemFwZ1LzMGNdMKsTr7J9uzfh2HIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219934; c=relaxed/simple;
	bh=sCzlW8dI0Fhs+cB9tikStcBigUiohJn/nNVBfBD/Z7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu9W6ROirt2PqIcSXStAuqUqrH1Zlep6lU2U3+L1V47+viFlg+UrNMa3HzOmj0CgFl+0c7GUF/ujkhDYDYNrxXpIXJSiYobtO257F+djktn2w/LKHwQFCfc7n650GeVT5U9jQRNc4tcUFgMao1Lfm+d6JQB9rE5u2Erx69MqIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXosfpvv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXosfpvv"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39378db197aso45065241fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219929; x=1779824729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/RJXFq6LqCe4pPTryrEabmW7igLHdURwee7mxbgIMM=;
        b=HXosfpvvqjwGGah9LaWiwiTOLDN9y74EgELO4GNA13CIUkaU0wLmjOl7DIBrKvTi+D
         0xRBswzU63hju6rKyIUIobmYXIUzcw/oNknqRrG8ANlUHEmBK81pgKcVDwKXYqMTvzGu
         XY8+cj5J804LZNipLq/S+cyrYrVrg4gwy3WBKTxIcbuXVpyCkeo9oZlhLN/2VP0Zezwl
         zAYzTOsT7MUSr7y3xAu9ArugTt7ThMb0ufVR6C0M76VxxoUv3Nx5ClEjX7gm+qDRX1+d
         JXtVbJ1UEaHZ/or43oRr2inE+Tp6bLKu9qPTJzfaKpewzTV1Dhuih5TBEsM1X0FmYzpC
         eA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219929; x=1779824729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/RJXFq6LqCe4pPTryrEabmW7igLHdURwee7mxbgIMM=;
        b=o7biLfpqeK0OSeU9oUMWrHKyaiUmVljXKEcBrYyseTY2ibj51SNoWGjHJEppHdcWxV
         2u1DfQDaNKq3Ro8lJju0QexXFKEtWxDEbxa5iYR1sHh9gOhP33nQLXkFy8FLfZ3zN+MS
         TU6T8G0sODGbSgWkK/ju+EVUVolUIG7+Huq+9t7XdYtNRSyn/gwXJmEUGACpR1SoTszn
         Pimogi4VwmI4PWST3iORSBPU3s/EcuWDL+BL3U21t6XCfOqr+ejFynCFZqkW2HOLSGiX
         KxcyGzZ7azYAoO5hB6SqryiYNjQS8w93WbQ5rmiM7JW9bXx+GQGoJE0/jmjiVMnN0HX4
         r96Q==
X-Gm-Message-State: AOJu0YzzDpygqZxVyVlsdNJmmG3xetbcwcV4mqKt3DOk/ZQCpkB7q4uo
	qFBaU3GWo28b078WjEitt9cCf7XE9OPVK4NOS7e5HpVPizbnhTl3o+72
X-Gm-Gg: Acq92OGJO3+9y8iXsHJeRFh3UL4bcD8r7JQAeK4Hiuu5mCFI9hsjLDzvlaYjX2A3jsi
	L+R42JAO+Fb/JZrfBEKXLYazbd6+2hpCv9o800dhaqMBk0opoJ5QCNZ1lTd3p7hx+7Y9PpoaWGN
	cj8UZurOtKM4KFte/0qHWIp2RqwnEfnn3r/elavMWrO3DI203MEhzPk1Rk0qqGu+WlryNjd4J9K
	I9Zr6zui6lJn/9KlWr2XNOeqSZUtff/e1RGml5a+0WXZADvEj1cIBSj+HsX0qD2WrpGWEgV7BVL
	nsugBOjNpLU7xdS0ffr3ficnHNpIql9qCYVPkBkw9H6vFk6cLsLVGqZ1ZnXkrx2lGLVQoT8i5Nw
	9KiquAV6MHdhxO3BdlsSfpfJuhUaUdFtQYW7qmyvZjrprOZPB1VmfyRGA5WTFsuB8qWMV8M8EaD
	E22vB7XU5xw6EnJ3xjAS+3EC+R9g==
X-Received: by 2002:a05:651c:435c:10b0:38a:2f02:e153 with SMTP id 38308e7fff4ca-39561f67d59mr55038531fa.31.1779219929166;
        Tue, 19 May 2026 12:45:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:28 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 05/11] srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
Date: Tue, 19 May 2026 21:45:18 +0200
Message-ID: <20260519194524.158515-6-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

s/srcu_read_lock_safe()/srcu_read_lock_fast_updown(), there being no
such thing as srcu_read_lock_safe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/srcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5..a54ce9e808b9 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -397,7 +397,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
  * and srcu_read_lock_fast().  However, the same definition/initialization
- * requirements called out for srcu_read_lock_safe() apply.
+ * requirements called out for srcu_read_lock_fast_updown() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires_shared(ssp)
 {
-- 
2.47.3

