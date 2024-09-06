Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC41494AC
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607398; cv=none; b=hF9Lbw1S/ea+HRGGRZrMWhGYFi7sgm4kKASo/TMsK7CYspOa+NXM7lyJPzQS8OIFd4wZR8Ct16y4fAgihJj+4+vgBwn0zmSdfqII+rZA5g4hADlakFodVUWb2mOpQYqF1ZwXUPblCizqIHoM/Zw81i33THSpp8CSlB50ijALq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607398; c=relaxed/simple;
	bh=GOhVz96SKhOzE1wKxb1dTvsMOclPUcCrvW4COvnp8Hg=;
	h=MIME-Version:From:To:Subject:Content-Type:Date:Message-ID; b=ACyANe/WT3MWDQCrA3ggoycYhkISsO1KuDu39H/uu92R5YeS/1gT6WOmjEiswSjajgFwkYSVqMhyZZOhgTKR6pKjB9UyhioRdRTcGxIipDjz7kOmqOmOVuCgbnjAsik7pIOHQ/K3AEZ7OyS759SekRFEg/l1kkLVP4t/pryH/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eyesonsolution.com; spf=pass smtp.mailfrom=eyesonsolution.com; dkim=pass (1024-bit key) header.d=eyesonsolution.com header.i=@eyesonsolution.com header.b=br3bnLwZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eyesonsolution.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyesonsolution.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eyesonsolution.com header.i=@eyesonsolution.com header.b="br3bnLwZ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-536584f6c84so636556e87.0
        for <rcu@vger.kernel.org>; Fri, 06 Sep 2024 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eyesonsolution.com; s=google; t=1725607394; x=1726212194; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:subject:to:reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GOhVz96SKhOzE1wKxb1dTvsMOclPUcCrvW4COvnp8Hg=;
        b=br3bnLwZXauwrocaxOY0I4NfjQCdv1sW/KhQ/DRyBIC7NiBYlebce8Dha9zchRoaYL
         mtBJwEqW3i0D6U6AqGoz4IxwJMbiT8XD+h0ir4C03Ic3csBYDZ1iiK6S87F2FD3N0ukK
         CK2mvtYH/X3/LEDooapMsT++TMZoQHt/7cP7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607394; x=1726212194;
        h=message-id:date:content-transfer-encoding:subject:to:reply-to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOhVz96SKhOzE1wKxb1dTvsMOclPUcCrvW4COvnp8Hg=;
        b=YljjiJ0khbE0GUuR78V53tyMHtkTZL+NVmjJhUna18mOFWmEFh0Z2BcYp7TtDho6u3
         YAuwZ9Ye8lZPhfyj0h7Px5zkYvlU4KsqBXZwmWrRqfjr+mMdPDCgU75QxYpxCP1jE33x
         o23lN3h8jXiOQRrxmOgxuRM0G+S3XnmeQsDF/gyZE86oCxZYBb6eqSsmUZgEVBUqG2L/
         uzQEWbMsK/cecr0mpll+lRR0g/pp14ljBEHiS0HZRu1Z5WLd65gKQsnH9/aemxjkRDbm
         ijW74m6OGCDuJxKDJodcF0TzcWa6w6d4gUqhyzXqpkUF9Dsh62iGno4mxtbDk2O8znYq
         sa0Q==
X-Gm-Message-State: AOJu0YxTnKivF+16zIZ4BgFXbA7yc95Cbcy7tmU3mN3t05qaOQJGfgWx
	s2RFRMWcbA5QXF9+oSSzrMCRFVF8Iw24opbRvF6UhHNuk7Wjj5bTMbhfiew3jckA/nj397NswcA
	X
X-Google-Smtp-Source: AGHT+IEJg1QYTVoWkDdAWdIw3Q2dicnhrugxMMJZAwVdZTJAhicu79y+1FFaRn5jI+Mg7peIhJLUww==
X-Received: by 2002:a05:6512:104b:b0:536:5625:511a with SMTP id 2adb3069b0e04-536587f82d0mr800251e87.47.1725607393618;
        Fri, 06 Sep 2024 00:23:13 -0700 (PDT)
Received: from 139.135.36.114 ([139.135.36.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccbf5sm10740925e9.16.2024.09.06.00.23.11
        for <rcu@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2024 00:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Mark Jackson" <mark@eyesonsolution.com>
Reply-To: mark@eyesonsolution.com
To: rcu@vger.kernel.org
Subject: Sponsored Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date: Fri, 6 Sep 2024 12:23:10 +0500
Message-ID: <1010425990844829431729@DESKTOP-7HSBNRP>

Hello,

I hope you're doing well when you read this email.

I am emailing you to see if you want to do sponsored posts.

We are looking for websites and blogs that are important for our clients.

You will receive high-quality content with a link that relates to your webs=
ite's topic.

Can you tell me how much you charge for each post=3F

We will send the payment to you using PayPal or Payoneer once your article =
is published.

Excited to work with you for a long time and create business opportunities =
together.

With warm regards,
Mark Jackson=20
