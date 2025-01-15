Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E12232441;
	Wed, 15 Jan 2025 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908619; cv=none; b=Qz5ay3CTUCJR/EAqENgcgYJ/jGQtXVpEVkiaYq1oT72k04Bzvr9Zx6lEFMxlYxR5nqMiDTd0Ja2DrBl7VkVlANzstxhhYTRmZ+xHY2mPwnos9gSUSOVf6kUSV/Kb8kdJ+llD2Uo1dqu2sFMD2cm2itM0xmHxbyzsvfBIdGI48hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908619; c=relaxed/simple;
	bh=TzMnNb+SGxxc0WEjZf39odl4521EWGy0qtYkCYqb/pI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xz7IJWcfr5oqX29itT5KBT3iFr3DfsfOPOqHWKgoRAKyd/tnJtzmtgfEwwK1INRPeGc2qIkaIYdlHRwu/eU7FQBZmWZ7kQHx/+YG49yXEP35FY3cnk1ZOlSMk/GXZUZBldWfruZRpW/6YUNoXJ7lh2CNDndnuhtsS2bCh/pULeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBschxz8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBschxz8"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee0b309adso1011068866b.3;
        Tue, 14 Jan 2025 18:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908616; x=1737513416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TzMnNb+SGxxc0WEjZf39odl4521EWGy0qtYkCYqb/pI=;
        b=VBschxz8QnYyWcZ09oVqrnMmHX796Uav+uznAoozs3LlTlj3cS418OicvymonfsZnC
         6HkRxZBuZPnM1u3HhDYY+QILA/ACAyUZypj3aIXT4l5rAMFJrcxZF0r7Pcjyg58bZDLY
         ws06KIwfvnJ+ZSbHX9riJn4zJr34uKawymrZhkuk5HKLE2XYQTSDUecDCuyoSzbRv6ON
         ljGIy5SBMUGpF5WoIUgtMY/ki7blZtvgq+ZQLPps+lV2C0NkR+TQpsrVmW6thAjREmYh
         7iqj3s/6DRUbd3dzPa27M8A6goLpvvmVPCF7SlHD/9VQFqzozMkXIxraPOM0WXEFMyzW
         gcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908616; x=1737513416;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzMnNb+SGxxc0WEjZf39odl4521EWGy0qtYkCYqb/pI=;
        b=BLFcZ7wvWTK9YsHr92HBrebJr2hN7srT+fxYPn6KlbMhgM7/3SWZiOAnwXmbXV/Zti
         KsjDj91O4zx118OyvbIvlLxGUk1bcB0zl89Oh0gJ5hJYLIvRtTd/IvF7I1DYCePqMrCc
         I3hx40J2u95r0hkIngbbRFNDARpbWPAnxzdeg7xeokWzTxb2NXFUsjbp8o9Lv7RkkbdO
         vZQGNr3qrdqvdjAl2WpBJkQxSjK1Q6FjrHYqKSb2VEItrn8oDqkEb3J3CDGq4GckeXjb
         BHlRSVtzYY2iYF/IRdpdbwfaSz6MTS9lbOjHDwdxxl1PrOzmX36Yx1mcjcn8s+P6AoUt
         hFpA==
X-Forwarded-Encrypted: i=1; AJvYcCV3GNo70tgQeLX2aj0PIYdeJw3x7v7QKenFb9fCE/7eIybvq/6Val8Q4whqYu1SuBIIJecz@vger.kernel.org, AJvYcCVxBFyOpxmSgGaw10CSVRlgdHwG63Xm9A+zptkbepQFt+iFGtmYKlRz/r1kxPluivYRf28rcyEjCzVff4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxHjtfzf+8NBxXqlzhXZT99s+WeWh4WSgsez6uF6wBrv/z02x
	s2uzgt3m6WUqYkXlFm+3bYIqY2OFALKfHo8cLuhQhvQ/WFXlZIFFs50g5RPLkqT6WkeLpQyrcRL
	MrCnZUDor2n1J3hTuyYclpL2pmhj8tM+F
X-Gm-Gg: ASbGncvWPKv2jsl5vK0miF3aFBAQhvTtXEf/tHJvPGiK/4W3z9zHTguNQZRcKwU3wzu
	SPTZvq1z/5hi5o+SvY28f3rY6tT2SrHiXfBfG+E8=
X-Google-Smtp-Source: AGHT+IFxDDWH/p8TjDyzzlmdGk0qjmcPpwo2K9wDzMKxfkKaPsykmWUitVK70rkKmY+pay46txya1MVzPKWOJXQYLLM=
X-Received: by 2002:a17:907:2dac:b0:aae:eb0b:f39a with SMTP id
 a640c23a62f3a-ab2abc6ea73mr2636951166b.42.1736908616172; Tue, 14 Jan 2025
 18:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 15 Jan 2025 10:36:44 +0800
X-Gm-Features: AbW1kvbKWLfU0KMEckiH_rawDCfDIVT21ZzjUy5whZ_nnWHL2dzBhxuAeFFxS2U
Message-ID: <CAKHoSAvbRnktnM=H52eNe0QQryP908Q612Hfxzy2sozUdHRrjQ@mail.gmail.com>
Subject: "WARNING in rcu_sr_normal_complete" in Linux Kernel v6.12-rc4
To: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version v6.12-rc4. This vulnerability was discovered
while i was testing the kernel.

Linux Kernel Repository Git Commit:
42f7652d3eb527d03665b09edac47f85fb600924 (tag: v6.12-rc4)

Bug Location: 0010:rcu_sr_normal_complete+0xd0/0x110 kernel/rcu/tree.c:1638

Bug report: https://pastebin.com/kuJ7wnPe

Entire Log: https://pastebin.com/fT42ya0T

Thank you for your time and attention.

Best regards

Wall
