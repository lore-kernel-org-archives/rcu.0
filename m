Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F5315772
	for <rcu@vger.kernel.org>; Wed,  7 Jan 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789993; cv=pass; b=JTcNopehGXmbDGdCTU7Eppzc4eUmZLHCffYwzplAc0h7wZ1pD33QDCq9sL4uz8YbikBnMJfNXQmpfcP5ezOU5LFjSz7mX44KNJA/a8usCg5bYGvX8/YguwRNByXbBrICBu1jUecQayWtvmn7i3KpxE0mO7D0XLa8CDupwd/pas4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789993; c=relaxed/simple;
	bh=diRXR2Re1+OHdUMzqSTY3/4W/RblejFu9jTBjKLGYAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAQ34ReZZnTNLdY0xFDPhS74rrMLYRYb1c3N3BM/t+CXyLGutX3fOqXleMcTCDKwKaiNuyM0Up6mq4sxIHdvB3vwHVm7sctnGJwfSI2tbGzUWduyI6NkBug2Oja0CCe+UPdbmGjqgZDwlIqeGT1On8JNCHgeaXx6zmWig53RPJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUg7YZRS; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUg7YZRS"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f42eaff60so134545c88.3
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 04:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767789991; cv=none;
        d=google.com; s=arc-20240605;
        b=dL1NgRwkL8cEi42MIT5OkKDcNR9cTP1xh3+3Xr+VHZEaRrXx7tF4O1ywNDjRk+v7Wm
         PT6rlYZ4j80nMNFGU9by++ddqu4iFH4tPMIBnIsHSeTttzAQY+g7nj2B573PxDPCU6BS
         oInPbHd71zXVYFARFl/+zUQQWu3wVyAgERJAKFUYk2IVp5VyNkTwpSzEDKb8BTQxbwIL
         SV5IGOe8GD+TcidUFKG2/NjUooD+85nSAfdihmEQHtuZANFJG061q7adADzDt88+yTh2
         WsbW6gmiRPNLcGUrVxxnyJQ6eHzj3KEdXzwCzvU9sI0Blx0G/nCio/W3UG5tSFcqkdiA
         RafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=diRXR2Re1+OHdUMzqSTY3/4W/RblejFu9jTBjKLGYAo=;
        fh=pUUVUbFH7KynhAVh2UzUqWy3ZWkhYN2C8r3a9A2bwag=;
        b=ZfzQVtwT8Ou5hLVElr/BdO91zMbzbXk5qxJ0Fb8adAlwf9XK1e+uIDBJYOPUZP+wYU
         EHzyqpFVuVCmmdRkUmWJEtjo8XiH1NIngYicTkRcL7GcYCSX2W3tnIinbSauUxys9Szw
         PRIV/KPJSQscse52k7R0itWt2Nvk/HH1LevGO4xst1oUuUXnVwmAdlkxp4ipeetSDDcI
         Cv5YSOVQ02wzmQO7BU8M51y7Hh4WDkKRkDYKKZHIDvnnYI5CkCU8DdNuq4MIsCBKjm6z
         3QIveKfrN8E59jH8jJTXRUr8VHdduCOYWTOpsdiTtZ2xgsIyhfPsCfOptrvw+raJwCGz
         +l7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767789991; x=1768394791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diRXR2Re1+OHdUMzqSTY3/4W/RblejFu9jTBjKLGYAo=;
        b=TUg7YZRSLBYwBtmyyyih02fLI1qyky3/MpMAu57IzXkhrhgAmGQXZesxA4OlU+TGJz
         Q33tvU0kF7I4Yv7vzrtBDtOKPGGandesFPRcn4KRIy39F/9SoQ75MJ410t+GG4BOOMIK
         7HFVoViM1u5DT878uY1FzLmDr77tsx52bqefT8y7LZT6vA1FEr3ykUvLlixNngF8PVq+
         PM4V9TIp2nYRr6ASLxFF3zOpr9ZamHlCQOJ7pzqIsgHNMQRlF7tFByzmmhSLRi3IQKU8
         U+A0weVqV1hYLHJ5vTEcdmufGqLkpHNWHGS+FnLriN5uMtYOLZtgAyjl2HBsuiBXhcxn
         Wefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789991; x=1768394791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diRXR2Re1+OHdUMzqSTY3/4W/RblejFu9jTBjKLGYAo=;
        b=cMWYZmom4eclxucZNfNg7+myj2umDEPaj/poaafIvup9Z5uZ87rF4D/UqGHdohNXFP
         TIMEN4laL2GgtRgIFDBpV4mVaQp8VfWM6HHkl+rlEQLxvl2jDVcwKB4BxrwC57ss1TQr
         KG3FXfmzGWI9mNEFAboym4Ii07FbzjB02LUdHXVy9PmDTrtBXW3zUDNdollsGLsjksP6
         ApzdTsXl0D+x2xl+ZO76sQDsnIkKP2D5CQ6sveQMfMI5VMVD1aU3x/WtPSvWtwqGjkJK
         C6A1mQYEs5M8xPUMj+wsI6Kzor+uFLSBBg43qxoixzgaOwgMRDfcuAhbVDoYTL4Ut3SQ
         AtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyJjSB0kqQV8BrOy1EZ9eZDk5CJnQmaxxXfg8yLmjqV+pwqHmv5AS+lz/DS21LV+q0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9f94fGWy0bcPu+lYcfdEcWlauBY0PfkURIq0PbT1Z9DDhcvY
	LrhOaqtGhFzcykEWI2zbNxLeh8a9cqTUhj8Q1NM5whu4BmIsgsvsbnzwLLkNVYoEd95pmj9gEJ0
	YfZbQ7piWAcjLsdq3fvWdItAaoYCiAbE=
X-Gm-Gg: AY/fxX4Tg3sLknFgE9FH42Z0KukebHahR42NWpz/EJOEX6evfaRXTgZ1T+9rDIuhQ8g
	fUQM6ANVtSbA43w4w1giZZbs2XLORThtGJozDlIevHTjTUAi8IFLFunU8ircXT5/EEEp8hJbY7c
	8x3PKbFMgz40cvRrKytYhTwvCX3u9WdELJNvYJfkst9FzrZwB5HeP9GNfAntqIxFebjRrh/UQ4S
	mX464XA01Piu1vUWdaKXz1PlkE1HCMTTlHvEtg56f8xGjqNvDUwTzvwhaiptfH7fwW2hRbyW4G4
	tmas3AHEGG52t0TBCMaevMgypJZOhUfhVr9qF1MgsI48k3c9rzYK8vLr0Hlqc+s8MN3rPXZWI34
	htjq3h4FeVyRrQ/sS5KHHiMk=
X-Google-Smtp-Source: AGHT+IHBFO+bAPP6V9b03rrjN1+f1r7uZEP39oWoXoE9m/s7w6G4H7XkX2N2kHMKJjrXVBAD8G3GKTzc0IzPpMR3ns0=
X-Received: by 2002:a05:7300:ad08:b0:2ae:593b:2163 with SMTP id
 5a478bee46e88-2b17d2b80d2mr977198eec.4.1767789990606; Wed, 07 Jan 2026
 04:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com> <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org>
In-Reply-To: <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Jan 2026 13:46:18 +0100
X-Gm-Features: AQt7F2oY3rJVLUAzPCfQNldNx5mLoh9iddgjtwFpYIBSLt204r2ybXXsoi4kwrU
Message-ID: <CANiq72mUCGL3f=GAYSZfMV1=NXpOjz4vsV7B3Pd-=EG8tmWC_A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
To: Joel Fernandes <joel@joelfernandes.org>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, nouveau@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Paul E McKenney <paulmck@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, rostedt@google.com, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:56=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> It is more important that mailing list traffic does not have issues which=
 unfortunately us and other company domains have experienced. I have been u=
sing my domain for a long time without incident.

You could consider a kernel.org one too!

Cheers,
Miguel
