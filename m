Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B3AFD0D
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821618; cv=none; b=iLbS5K5WDpaoHANHow2didtspUW09QYEoBc0mg5B2Efr80+FX++xZmF2mYz1AQ3Cp/lY3Vbznc5HT+xKFdo0xXmk8JLew0sxxWV636wqrtMdQVqzaJkwjDkvGVakWQHVK5C/EMp4EtugOWD1RBiXs9bClGQttoxqtL0EEyBwAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821618; c=relaxed/simple;
	bh=Dv5HfCA1mSh6i3Acx6oZ4tgPaqHqwItmYmm43jb19IE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BeffNqH7GD26w2fMGzBdtj5Uqv2JDbBxuTN+ZcFmlYLCDwTPgx0tyblarz9cjDkNMbQmcV6NO5RuXxJxnFzk4jWWo5Sqc8ZjiaXLmrlNNbaSc+P0mrNfAnhX94rw2q2j8t8moi4aB1noY3+QG4VitRdTfWlDngsYdsxWSKHeFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWIyBcZG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oYjW2WBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWIyBcZG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oYjW2WBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UnIBDxp0KwBLclKxiCvoL0emivWc8/d/qvxTInSqzl0=;
	b=RWIyBcZGz1Dl5EvDGaxrWzjavcUAaDmclPcPJdIsdFf/LudHYOlaJTwif5jrwNOJghO8Df
	2OoCUObVkkYVY/a9rMjJiHgmhFoBC+enzCF2xsz0kjn5S2hulltjPK87bdgv+he9WXz9FE
	51HqPgu88T0FqY6PXLxt/iqSBxRzhQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-_AqyyoLRM3eWNPJSpQ8isw-1; Thu, 27 Aug 2026 05:06:43 -0400
X-MC-Unique: _AqyyoLRM3eWNPJSpQ8isw-1
X-Mimecast-MFC-AGG-ID: _AqyyoLRM3eWNPJSpQ8isw_1787821603
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so12099145e9.2
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787821603; x=1788426403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnIBDxp0KwBLclKxiCvoL0emivWc8/d/qvxTInSqzl0=;
        b=oYjW2WBgwaPCifGU9A71LJ3LNtT3IRqfjNBW0EzIJpXU3VRDAu9QmknI+ZrTvwLIHf
         +iKPhzarcZosnU80dN2Qb0B25u2NIDnC0Lql5EnPzoRycyrCOB9oVmuwC+NL8/M/8a5T
         CFo4bWwYJ8jQkgBdfQ1Q9S5/E3OC9sZpBuT+hYXcFODxjVicy4JUmJ4ktrwd9qyduG8i
         e12VaLHpT45UawLrcQcQ7pwfi++OdzXd0yy83lHfcUmc8kr1/XiB4tJt7Vn5crXZIGjh
         40pipkaMmXPk7clzG6R4iLnmTzzT4KWmYANOUu9lc2JrFLn8k+dF4m5zvjdxQf6u4MM7
         UkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821603; x=1788426403;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnIBDxp0KwBLclKxiCvoL0emivWc8/d/qvxTInSqzl0=;
        b=k8AUix21V2KQ52TKvErHSKFBW1s/rLjrJ5NAZYIL5rWmLoy3ycP0tXOA4djLh6nDAs
         595OgfkRxYNOOQdqQ99SvH1LuKZF5J8OGM6xwv9GamiqtXwF74g59EqwhUQxO8+Z7IyQ
         6o8g1EetQia23dVXXn2t4syzJMF30F2xsIkg3317pSEB+jfcB0M+VE9j+82wI9i5QDZT
         HBkVW5lw8aUJzXftkvUj7DF9e48q0hJ1vLvAHvWO9haQcgD6iOFe/vFO0Ru3W3KpKdCd
         pCIgz0kriGlpCrYOlZtLfi6us1yxe+xFjo0rZhDLc9si0TGThFqOAg6VwtC/VED4yMc/
         YHZQ==
X-Forwarded-Encrypted: i=1; AHgh+RonU7lQ3fA+eVbKm5YNZ1SfGXE5WQ8GetQFY9rL+C6Ue7xP5rPioAoJlpLjRfIHz25LeEM=@vger.kernel.org
X-Gm-Message-State: AFuF++mYLTDe8GOc3s27TFP9k5xNnB50sXXZWndjXv5Zk0nvjXtv/zVf
	pRsdvizYlibx7MO58u0KfDwXKeakdIJlB27wXTLuN+gjnXzjgK5jLBjUCApf2N5Nn7Jpg4I8q1g
	onawIwanXz3eXXWm0ZjcDcwma4jiA47myILiUrJ1bIvaV7c6/1CzFgA==
X-Gm-Gg: AR+sD13eek1696pXJyk2Ck8phZ/ic/CMqcnlrNLB5xqw1hTKqQi9n2yUMKYimzuwb+z
	M3NNF3clNkB62s32PmKlGC216yigYX4gy5dMVAHdatr5Wz0nAEoD8gp3FOqEBHuEOy32HXjowyV
	HkcMDJrpfJQrj6Ppm0+iIWNaI2ooE6FsMUzvOJMO1Hue5MgM3XN3NCgnzROUDQwwBJTmbqIpvei
	RQopMwibVOVmEY5uXWNO85//9w1LEvDmFaSS0k0J2fOFvRWz1hdb/9xDv/M+jYbZbJ1FOM8tyPc
	HZw2V7WirK9csNcbFvhQroAFkxpWyeu/J3vL4nhpX8pd070F2kFZq+wbx+vPRAnx9U+wUAnAwpZ
	XvdM8rCb5rGoLlbSO
X-Received: by 2002:a05:600c:37c9:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b2796c07cmr65580715e9.11.1787821602726;
        Thu, 27 Aug 2026 02:06:42 -0700 (PDT)
X-Received: by 2002:a05:600c:37c9:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b2796c07cmr65579825e9.11.1787821602271;
        Thu, 27 Aug 2026 02:06:42 -0700 (PDT)
Received: from cshulyup.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd55dd4bsm54770655e9.3.2026.08.27.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:06:41 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1] doc: RCU: Fix typo
Date: Thu, 27 Aug 2026 12:05:06 +0300
Message-ID: <20260827090506.1172620-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit

strategem -> stratagem.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..b10e0484ae13 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1442,7 +1442,7 @@ periods:
    corresponding CPU's next scheduling-clock.
 #. CPUs mentioned in the ``nohz_full`` kernel boot parameter can run
    indefinitely in the kernel without scheduling-clock interrupts, which
-   defeats the above need_resched() strategem. RCU will therefore
+   defeats the above need_resched() stratagem. RCU will therefore
    invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
    after 109 milliseconds.
 #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
-- 
2.55.0

