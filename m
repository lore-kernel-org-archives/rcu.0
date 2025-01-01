Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B8944E;
	Wed,  1 Jan 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735719810; cv=none; b=WM3RWCBg6XGVOwULdwx0oO/I8HwW0PuuEiplGuSNt4U+vl8nmlNe7wa1azd2lrWBGFZoo7vqeb010t3sWULB9Cmw74Jl2eMPl0HQs+JN8OxsN3XtMqE1Rc7STKIfXPYm7pIOy0xpmdiNl+I/y6kiLKroufbszpzK9HHwmCxkFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735719810; c=relaxed/simple;
	bh=eFnrZCBimAjK1iNLMq+V4c1epT86z2CuPjVS0TBfM3c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S287/BQmO2AvFjXyBP1Z+kC3+1nMvoJzCzu3V/XwzPX0L2Z5iugcJwQF4aL/on1VqgcRqREs3dzB+guOX8ml6IKxotk1g5KTPRppuI946510/ngT560ABGMGrSL67K5vyMJaXXBcOwxIWgOY7vw5iHVsQ30Hnshe7X0+C0Zxk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8j5JE6g; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8j5JE6g"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf60d85238so258652166b.0;
        Wed, 01 Jan 2025 00:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735719804; x=1736324604; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iezMTi+Wk0YO6uHIoxVpP5N0lA9JFSlHLULmqCXRjtE=;
        b=H8j5JE6gKyd0x1dbAOYhnDD8UJVaLIiPgCwllqBCq9EuYWR77kbx+gcdVSpNwkwfUm
         ZoAiqevUuvzLbt6sUB9f4Mz1y/XvJWgI4RL9B7SgUhkw7dOjF37OGbaYEUI1fVM/3aT2
         8tzWO7mJAsYLy3y0tvgG37uJbUr+vG1WQu0Z2o4KdKsGjgoKm6iDxvYecqh45ufvf/Kt
         PXT7ETBiyn8jB09gVjY94y9e4cvBrXeeJKhCYwtVGz1bflVnyg2JIGTAyPZZbl+Q04PL
         rhFamUyAob+Ff5q+txixxgrTtbAGgMRa6KxPVFyATFuTIYnycdR/uswi5/E8yQNLf/JG
         2JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735719804; x=1736324604;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iezMTi+Wk0YO6uHIoxVpP5N0lA9JFSlHLULmqCXRjtE=;
        b=MeRpCgn1qrEk7fD8L4h4ryqBxpb24ixxxwDhYereTPn0VCDpVr5Als1wl7falBzYJZ
         W13lu9BFm/RyG8jlcfvTbZQp7wt7P6U6g0/ImbUAPvnn3uOIhtIcBU2tsuvMOBWckiAS
         5E6Mq5x3xe2fyxcFnZtgHm50XZ3Vp6ZA8G4Lw4JOhT/imDNfZSHUGxV/3vsrJ2ntjEvC
         X1m98T46lOpP0WNyFwv+PvBOg941OUCmb8Okg6luCTtv3eD3qA0F7mwgzEP9BtYg0MP+
         hZksfvlTyWpV5RCfdkV9e2REQAp6ONwZGFnsFf/NwEyW5lx5oiKekOyq5y4+d5Y7AvG1
         y+tg==
X-Forwarded-Encrypted: i=1; AJvYcCW2J/KUYqX19cFdl3wyxedM5dh1loswDcI8xzPHSfjGAaLc9eFS76r+J0jk4sd8eM9zDq4COj1dhSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiunN/T9pxqjdHEht0jWjbrRkXNpjg8D27qWSqPDlnAbekrhvd
	nppzfR7e6JTYOSgLxFhUcsurTVcTyCUjeJ7/fZqKcyylJAQTlC/I
X-Gm-Gg: ASbGnctAem/4yq+eDvfcjXQZK3oe9QDG8j/shEF2CzJKGpvECZZtGANwFrtDXYpF6te
	vINJT1gFC2DXB/XjxQKNkCq2v2Di/sD3hU9xNe2bTfDWGyNOfnX5leOsmGlMKRlNVyO3XCeKwxS
	h9iUsQPzUQn8M5UL8mJyl+DPye7j4AxF/YCm4tsW4kSmRTl+cwFVZDdgEFiIg8Sn/xtVxOBy/5g
	XEVeD71VBEj3N1ArwgguTuMwme3LbP8HtbTuXQ+hpu31sTsrSkNlFwO
X-Google-Smtp-Source: AGHT+IHUsPKoExEUYgb8QB+FfXLmcBFzsj2g5f/zAu5kOQz0mVQwG5fQHynbXi3OkaYhAxDYULS6cA==
X-Received: by 2002:a17:907:7f0f:b0:aac:1e96:e7cf with SMTP id a640c23a62f3a-aac334425abmr4249112066b.20.1735719803813;
        Wed, 01 Jan 2025 00:23:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f858sm1680708366b.21.2025.01.01.00.23.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2025 00:23:21 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] doc/RCU/listRCU: fix an example code snippets
Date: Wed,  1 Jan 2025 08:23:06 +0000
Message-Id: <20250101082306.10404-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The example code for "Eliminating Stale Data" looks not correct:

  * rcu_read_unlock() should put after kstrdup()
  * spin_unlock() should be called before return

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
Hope my understanding is correct.
---
 Documentation/RCU/listRCU.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index ed5c9d8c9afe..8df50fcd69fd 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
 					rcu_read_unlock();
 					return AUDIT_BUILD_CONTEXT;
 				}
-				rcu_read_unlock();
 				if (state == AUDIT_STATE_RECORD)
 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
+				spin_unlock(&e->lock);
+				rcu_read_unlock();
 				return state;
 			}
 		}
-- 
2.34.1

